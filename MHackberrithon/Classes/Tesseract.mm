//
//  Tesseract.mm
//  Tesseract
//
//  Created by Loïs Di Qual on 24/09/12.
//  Copyright (c) 2012 Loïs Di Qual.
//  Under MIT License. See 'LICENCE' for more informations.
//

#import "Tesseract.h"

#import "baseapi.h"
#import "allheaders.h"
#import "environ.h"
#import "pix.h"
#import "MHData.h"

namespace tesseract {
    class TessBaseAPI;
};

@interface Tesseract () {
    tesseract::TessBaseAPI* _tesseract;
    uint32_t* _pixels;
    Boxa* _boxa;
    
    Boxa* _lines;
    Boxa* _blocks;
}

@end

@implementation Tesseract

+ (NSString *)version {
    return [NSString stringWithFormat:@"%s", tesseract::TessBaseAPI::Version()];
}

- (id)initWithDataPath:(NSString *)dataPath language:(NSString *)language {
    self = [super init];
    if (self) {
        _dataPath = dataPath;
        _language = language;
        _variables = [[NSMutableDictionary alloc] init];
        
        [self copyDataToDocumentsDirectory];
        _tesseract = new tesseract::TessBaseAPI();
        
        BOOL success = [self initEngine];
        if (!success) {
            return NO;
        }
    }
    return self;
}

- (BOOL)initEngine {
    int returnCode = _tesseract->Init([_dataPath UTF8String], [_language UTF8String]);
    return (returnCode == 0) ? YES : NO;
}

- (void)copyDataToDocumentsDirectory {
    
    // Useful paths
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = ([documentPaths count] > 0) ? [documentPaths objectAtIndex:0] : nil;
    NSString *dataPath = [documentPath stringByAppendingPathComponent:_dataPath];
    
    // Copy data in Doc Directory
    if (![fileManager fileExistsAtPath:dataPath]) {
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]] bundlePath];
        NSString *tessdataPath = [bundlePath stringByAppendingPathComponent:_dataPath];
        if (tessdataPath) {
            [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:NULL];
            [fileManager copyItemAtPath:tessdataPath toPath:dataPath error:nil];
        }
    }
    
    setenv("TESSDATA_PREFIX", [[documentPath stringByAppendingString:@"/"] UTF8String], 1);
}

- (void)setVariableValue:(NSString *)value forKey:(NSString *)key {
    /*
     * Example:
     * _tesseract->SetVariable("tessedit_char_whitelist", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
     * _tesseract->SetVariable("language_model_penalty_non_freq_dict_word", "0");
     * _tesseract->SetVariable("language_model_penalty_non_dict_word ", "0");
     */
    
    [_variables setValue:value forKey:key];
    _tesseract->SetVariable([key UTF8String], [value UTF8String]);
}

- (void)loadVariables {
    for (NSString* key in _variables) {
        NSString* value = [_variables objectForKey:key];
        _tesseract->SetVariable([key UTF8String], [value UTF8String]);
    }
}

- (BOOL)setLanguage:(NSString *)language {
    _language = language;
    int returnCode = [self initEngine];
    if (returnCode != 0) return NO;
    
    /*
     * "WARNING: On changing languages, all Tesseract parameters
     * are reset back to their default values."
     */
    [self loadVariables];
    return YES;
}

- (BOOL)recognize {    
    int returnCode = _tesseract->Recognize(NULL);
    return (returnCode == 0) ? YES : NO;
}

-(NSMutableArray *) recognizeByWord{
    _tesseract->Recognize(0);
    tesseract::ResultIterator* ri = _tesseract->GetIterator();
    tesseract::ChoiceIterator* ci;
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    if(ri != 0)
    {
        do
        {
            const char* symbol = ri->GetUTF8Text(tesseract::RIL_TEXTLINE);
            NSLog([NSString stringWithUTF8String:symbol]);
            float confidence = ri->Confidence(tesseract::RIL_TEXTLINE);
            int left, top, right, bottom;
            ri->BoundingBox(tesseract::RIL_TEXTLINE, &left, &top, &right, &bottom);
            MHData *data = [[MHData alloc] initWithConfidence:confidence word:[NSString stringWithUTF8String:symbol] left:left right:right top:top bottom:bottom];
            
            [dataArray addObject:data];
            /*
            if(symbol != 0)
            {
                float conf = ri->Confidence(tesseract::RIL_SYMBOL);
                std::cout << "\tnext symbol: " << symbol << "\tconf: " << conf << "\n";
                
                const tesseract::ResultIterator itr = *ri;
                ci = new tesseract::ChoiceIterator(itr);
                
                do
                {
                    const char* choice = ci->GetUTF8Text();
                    std::cout << "\t\t" << choice << " conf: " << ci->Confidence() << "\n";
                }
                while(ci->Next());
                
                delete ci; 
            }*/
            
            delete[] symbol;
        }
        while((ri->Next(tesseract::RIL_TEXTLINE)));
    }
    return dataArray;
}

- (NSString *)recognizedText {
    char* utf8Text = _tesseract->GetUTF8Text();
    return [NSString stringWithUTF8String:utf8Text];
}

- (float)getTextDirection {
    bool flag;
	int out_offset;
	float out_slope;
	flag = _tesseract->GetTextDirection(&out_offset, &out_slope);
    return out_slope;
}

- (void) getWordBoxes {
    _boxa = _tesseract->GetWords(NULL);
}

- (void) getLineBoxes {
    _lines = _tesseract->GetWords(NULL);
}

- (void) getBlockBoxes {
    _blocks = _tesseract->GetTextlines(NULL, NULL);
}

- (int) getBlockCount {
    return _blocks->n;
}

- (CGRect) getBlock:(int) i{
    Box** boxes = _blocks->box;
    return CGRectMake(1.0*boxes[i]->x, 1.0*boxes[i]->y, 1.0*boxes[i]->w, 1.0*boxes[i]->h);
}


- (int) getBoxesCount {
    return _boxa->n;
}

- (CGRect) getBoxes:(int) i{
    Box** boxes = _boxa->box;
    return CGRectMake(1.0*boxes[i]->x, 1.0*boxes[i]->y, 1.0*boxes[i]->w, 1.0*boxes[i]->h);
}

- (void)setImage:(UIImage *)image
{
    free(_pixels);
    
    CGSize size = [image size];
    int width = size.width;
    int height = size.height;
	
	if (width <= 0 || height <= 0) {
		return;
    }
	
    _pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // Clear the pixels so any transparency is preserved
    memset(_pixels, 0, width * height * sizeof(uint32_t));
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // Create a context with RGBA _pixels
    CGContextRef context = CGBitmapContextCreate(_pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // Paint the bitmap to our context which will fill in the _pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
	
	// We're done with the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //LEPT_DLL extern PIX * pixRotateAM ( PIX *pixs, l_float32 angle, l_int32 incolor );
    //_pixels = (uint32_t*)pixRotateAM((PIX*)_pixels, (l_float32)(-3.1415926/2), (l_int32)0xffffff);

    //_pixels = pixRotateAM(_pixels,3.141592653589/2,L_BRING_IN_WHITE);
    
    _tesseract->SetImage((const unsigned char *) _pixels, width, height, sizeof(uint32_t), width * sizeof(uint32_t));
}

- (int) getWordConfidenceAt: (int) i{
    int *confidence = _tesseract->AllWordConfidences();
    return confidence[i];
}

- (char *) getWordAt: (int) i{
    return _tesseract->GetBoxText(i);
}

@end

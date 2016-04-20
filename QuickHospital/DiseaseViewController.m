//
//  DetailViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/22.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiseaseViewController.h"
#import "DocterCountViewModel.h"
#import "DiseaseDetailViewController.h"
#import "ComplicationViewController.h"
#import "DiagnoseViewController.h"
#import "Complication.h"
#import "DoctorViewController.h"
#import "Disease.h"
#import "Diagnose.h"
#import "BorderAndCornerTool.h"

@interface DiseaseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *doctorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *diseaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyLabel;

@property (weak, nonatomic) IBOutlet UIButton *diagnoseBtn;
@property (weak, nonatomic) IBOutlet UIButton *suspectBtn;
@property (weak, nonatomic) IBOutlet UIButton *acceptedBtn;
@property (weak, nonatomic) IBOutlet UIButton *nonAcceptedBtn;

@property (weak, nonatomic) IBOutlet UIView *diseaseDetailView;
@property (weak, nonatomic) IBOutlet UILabel *diseaseDetailLabel;

@property (weak, nonatomic) IBOutlet UIView *complicationView;
@property (weak, nonatomic) IBOutlet UILabel *complicationLabel;

@property (weak, nonatomic) IBOutlet UIView *diagnoseView;
@property (weak, nonatomic) IBOutlet UIView *acceptView;

@property (weak, nonatomic) IBOutlet UIView *treatView;
@property (weak, nonatomic) IBOutlet UILabel *treatLabel;

@property (nonatomic, assign) NSInteger ci2Id;
@property (nonatomic, assign) NSInteger ci3Id;
@property (nonatomic, strong) NSArray *choosedComplications;
@property (nonatomic, strong) Diagnose *choosedDiagnose;

@end

@implementation DiseaseViewController

- (IBAction)toDiseaseDetail:(id)sender {
    DiseaseDetailViewController *dvc = [[DiseaseDetailViewController alloc] init];
    dvc.ci1Id = self.ci1Id;
    dvc.chooseDetail = ^(NSString *name, NSInteger ci2Id, NSInteger ci3Id) {
        self.diseaseDetailLabel.text = name;
        self.diseaseDetailLabel.textColor = [UIColor darkGrayColor];
        
        self.ci2Id = ci2Id;
        self.ci3Id = ci3Id;
        
        self.applyLabel.backgroundColor = ThemeColor;
    };
    [self.navigationController pushViewController:dvc animated:YES];
}

- (IBAction)toComplication:(id)sender {
    if (self.ci2Id < 1) {
        [MBProgressHUD showErrorWithStatus:@"请选择疾病细分" inView:self.view];
        return;
    }
    
    ComplicationViewController *cvc = [[ComplicationViewController alloc] init];
    cvc.ci2Id = self.ci2Id;
    cvc.choosedComplications =[NSMutableArray arrayWithArray:self.choosedComplications];
    cvc.chooseComplication = ^(NSArray *complications) {
        self.choosedComplications = complications;
        if (complications.count < 1) {
            self.complicationLabel.text = @"请选择并发症(可多选)";
            self.complicationLabel.textColor = [UIColor lightGrayColor];
            return;
        }
        
        NSMutableString *strM = [NSMutableString stringWithString:@"["];
        for (int i = 0; i < complications.count; i++) {
            Complication *complication = complications[i];
            [strM appendString:complication.complication_name];
            if (i < complications.count - 1) {
                [strM appendString:@","];
            }
        }
        [strM appendString:@"]"];
        
        NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithString:strM attributes:@{
                                                                                                               NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                                                                               NSFontAttributeName: [UIFont systemFontOfSize:14]
                                                                                                               }];
        
        NSString *str = [NSString stringWithFormat:@"(共%ld条)", complications.count];
        NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:str attributes:@{
                                                                                              NSForegroundColorAttributeName: ThemeFontColor,
                                                                                              NSFontAttributeName: [UIFont systemFontOfSize:14]
                                                                                              }];
        
        [aStrM appendAttributedString:aStr];
        self.complicationLabel.attributedText = aStrM;
    };
    
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)toTreat:(UITapGestureRecognizer *)sender {
    DiagnoseViewController *dvc = [[DiagnoseViewController alloc] init];
    dvc.choosedDiagnose = self.choosedDiagnose;
    dvc.chooseDiagnose = ^(Diagnose *diagnose) {
        self.treatLabel.text = diagnose.diagnosis_type_name;
        self.treatLabel.textColor = [UIColor darkGrayColor];
        
        self.choosedDiagnose = diagnose;
    };
    [self.navigationController pushViewController:dvc animated:YES];
}


- (IBAction)chooseDiagnoseOrNot:(UIButton *)sender {
    sender.selected = YES;
    if (sender == self.diagnoseBtn) {
        self.suspectBtn.selected = NO;
    } else {
        self.diagnoseBtn.selected = NO;
    }
}

- (IBAction)chooseAcceptedBtnOrNot:(UIButton *)sender {
    sender.selected = YES;
    if (sender == self.acceptedBtn) {
        self.nonAcceptedBtn.selected = NO;
        self.treatView.hidden = NO;
    } else {
        self.acceptedBtn.selected = NO;
        self.treatView.hidden = YES;
    }
}

- (IBAction)apply:(UITapGestureRecognizer *)sender {
    if ([self.applyLabel.backgroundColor isEqual:ThemeColor]) {
        Disease *disease = [[Disease alloc] init];
        disease.ci1_id = self.ci1Id;
        disease.ci2_id = self.ci2Id;
        disease.ci3_id = self.ci3Id;
        disease.complications = [self.choosedComplications valueForKeyPath:@"complication_id"];
        disease.is_confirmed = self.diagnoseBtn.selected ?1 : 2;
        disease.has_diagnosis = self.acceptedBtn.selected ?1 : 2;
        disease.diagnosis_type = self.choosedDiagnose ?self.choosedDiagnose.diagnosis_type_id : 10000;
        
        disease.page_size = 15;
        
        DoctorViewController *dvc = [[DoctorViewController alloc] init];
        dvc.disease = disease;
        [self.navigationController pushViewController:dvc animated:YES];
    } else {
        [MBProgressHUD showErrorWithStatus:@"请选择疾病细分" inView:self.view];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)setupUI {
    self.diseaseLabel.text = [NSString stringWithFormat:@"疾病类型:%@疾病", self.diseaseName];
    [DocterCountViewModel getDocterCountWithCi1Id:self.ci1Id responseHandler:^(NSInteger count) {
        self.doctorCountLabel.text = [NSString stringWithFormat:@"%ld", count];
    }];
    
    [BorderAndCornerTool setBorderAndCornerWithView:self.diseaseDetailView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.complicationView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.diagnoseView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.acceptView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.treatView];
}

- (void)setupBorderAndCornerOfView:(UIView *)view {
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = Color(208, 208, 208).CGColor;
    view.layer.borderWidth = 1;
}

@end
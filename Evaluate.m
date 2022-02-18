function Jaccard = Evaluate(real_label,pre_label)
% This fucntion evaluates the performance of a classification model by
% calculating the common performance measures: Accuracy, Sensitivity,
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input: ACTUAL = Column matrix with actual class labels of the training
%                 examples
%        PREDICTED = Column matrix with predicted class labels by the
%                    classification model
% Output: EVAL = Row matrix with all the performance measures
% https://www.mathworks.com/matlabcentral/fileexchange/37758-performance-measures-for-classification
 
idx = (real_label()==1);
 
p = length(real_label(idx));
n = length(real_label(~idx));
N = p+n;
 
tp = sum(real_label(idx)==pre_label(idx));
tn = sum(real_label(~idx)==pre_label(~idx));
fp = n-tn;
fn = p-tp;
 
tp_rate = tp/p;
tn_rate = tn/n;
 
accuracy = (tp+tn)/N; %׼ȷ��
sensitivity = tp_rate;  %�����ԣ���������
specificity = tn_rate; %�����ԣ���������
precision = tp/(tp+fp);  %����
recall = sensitivity;  %�ٻ���
f_measure = 2*((precision*recall)/(precision + recall));  %F-measure
gmean = sqrt(tp_rate*tn_rate);
Jaccard=tp/(tp+fn+fp); %Jaccardϵ��
 
result = [accuracy sensitivity specificity precision recall f_measure gmean Jaccard];

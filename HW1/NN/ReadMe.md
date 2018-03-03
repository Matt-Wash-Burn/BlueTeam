How to use Question 2 Part 3 code
1. Download the dataset from Kaggle. Will need to unzip the tar file to get
   the .csv file.
2. Run the HW1_Question2_Part3.m file from lines 1 - 105. This will parse
   the data file into something useful for us. 
3. After it is done running, type nnstart into the command line of matlab.
4. After the Neural Network opens, click on pattern recognition.
5. Click "next" in the welcome screen and go to "Select Data"
6. For inputs, Xtrain. For targets, Ytrain.
7. Click "Next" and go to "Validation and Test Data". Accept the default 
   settings and click "Next" again. This will split the data into 70-15-15 
   for the training, validation and testing sets.
8. In the "Network Architecture", change the value for the number of hidden 
   neurons, 400, and click "Next" again. 
9. Then Click Train.
10.When done, press next. Then, press next to skip Evaluate Network. In 
  "Deploy Solution", select "MATLAB Matrix-Only Function" and save t the 
   generated code. I save it as myNNfun.m
11. When finished, you can now run the code from lines 113 - 116.
12. Lastly, you can run lines 123 - 177 to sweep iterations 
    to see how accurate our 400 hidden nuerons were. 


## Question 2 Part 5 code

1. Open NN_Q5C.m 
2. Set up Matlab for parrallel pooling. 
3. Run whole file. 
4. ROC curves of each sweep will be save automatically to Q5figSaves. 
5. Results are then displayed with report2.m publish. 


!!! PLEASE READ - IMPORTANT !!!

There is no reason you should alter either 1_1_Feature_Selection_Code.R and 1_2_Feature_Seleciton_Environment.RData.
The only reason they are used is to generate the 20 Most Important Features.

Learn to save and load your environments. If it takes 8 hours to run a command and you don't save the environment.
You have to use 8 more hours to do it again.

You can copy 2_1_Default_Code.R and 2_2_Default_Environment.RData. To start training your models.
Copy and Rename the two files based on your portion of the project.

SEPERATING THE ENVIRONMENT IS IMPORTANT, Github has a 100MB limit on files, without using other features.

1_1_Feature_Selection_Code.R

    This is the code I used to find the 20 most important features.
    This took 8 days, 14 hours (206 hours) to complete and create the 1_2_Feature_Seleciton_Environment.RData

1_2_Feature_Seleciton_Environment.RData

    This is the environment data created by 1_1_Feature_Selection_Code.R

2_1_Default_Code.R

    This is the default code for everyone's projects. It has columns totaling zero remove and the 10 most important features selected.

    I selected the Top 10 Most Important Features.
    This was done in an effort to save processing time.

2_2_Default_Environment.RData

    This is an enivornment created from 2_1_Default_Code.R.
    This isn't needed the environment only takes seconds to finish. It is here to be consistant.

3_1_SVM_Code.R

    This is the code for generating the SVM Model.

3_2_SVM_Environment.Rdata

    This is the environment created by 3_1_SVM_Code.R.
    
        $everything
        user   system   elapsed 
    15144.53   125.51   16101.78 

        $final
        user  system    elapsed 
    316.76    0.86      333.77











References

only 20 most important variables shown (out of 68)

Overall

    Bwd.Packet.Length.Mean  0.3640
    Avg.Bwd.Segment.Size    0.3640
    Bwd.Packet.Length.Max   0.3333
    Bwd.Packet.Length.Std   0.3320
    Destination.Port        0.2599
    URG.Flag.Count          0.2145
    Packet.Length.Mean      0.2064
    Average.Packet.Size     0.2056
    Packet.Length.Std       0.1969
    Min.Packet.Length       0.1827
    Max.Packet.Length       0.1717
    Packet.Length.Variance  0.1665
    min_seg_size_forward    0.1659
    Flow.IAT.Max            0.1505
    Flow.Duration           0.1460
    Bwd.Packet.Length.Min   0.1337
    Fwd.IAT.Std             0.1289
    Avg.Fwd.Segment.Size    0.1274
    Fwd.Packet.Length.Mean  0.1274
    Flow.IAT.Std            0.1254



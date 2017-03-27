clc
clear 
load DataStructure_WorkingSet.workspace 
clc
ReqNet = skim({'CSS344','CSS220','CSS341'},ReqNet);
ReqNet = yearFilter(ReqNet, 2);
ReqNet = scheduleMatching(ReqNet, {1,3});
ReqNet = timeFilter_multiPair(ReqNet, studentTimes);

ReqNetArray = clashDetection_planCreation(ReqNet);
ReqNetArray = prerequisites_multiPlans(ReqNetArray);
ReqNetArray
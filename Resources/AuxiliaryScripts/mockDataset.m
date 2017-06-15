function [retval] = mockDataset(lpcb)            % lpcb = largestPossibleCourseNumber
  Courses = sort(randList_nElements(1:lpcb));
  for c = 1:length(Courses)
          courseName = int2str(Courses(c));
          ReqNet.(courseName).CourseSchedule = [];
          year = 1;
          quarters = randList_nElements(1:4);
          
          for q = 1:length(quarters)
                  days = randList_nElements(1:7);
                  for d = 1:length(days)
                          startTime = randList_nElements(42:90)(1);          % 7 am - 3 pm
                          endTime = startTime+12;                        % 2 hours gap
                          %printf("Course=%d \t Quarter=%d \t Day=%d \n startTime=%d \t endTime=%d\n", Courses(c), quarters(q), days(d), startTime, endTime);
                          arr = [startTime, endTime, days(d), quarters(q), year];
                          ReqNet.(courseName).CourseSchedule{length(ReqNet.(courseName).CourseSchedule)+1} = arr;
                  endfor
          endfor
          ReqNet.(courseName).credits = randList_nElements([2, 5])(1);
          ReqNet.(courseName).taken = 0;
          ReqNet.(courseName).preReqs = [];
          allPrevCourses = Courses(1:c-1);
          preqCourses = randList_nElements(allPrevCourses);
          pcLimit = length(preqCourses);
          if pcLimit > 10
                  pcLimit = unidrnd(10);
          endif
          for pc = 1:pcLimit
                  ReqNet.(courseName).preReqs{length(ReqNet.(courseName).preReqs)+1} = preqCourses(pc);
          endfor
  endfor
  writeJSON(ReqNet,'ReqNet');
endfunction

clear

%% Added functionality

%{
Courses = randList_nElements(1:3);
for c = 1:length(Courses)
        year = 1;
        quarters = randList_nElements(1:4);
        
        for q = 1:length(quarters)
                days = randList_nElements(1:7);
                for d = 1:length(days)
                        startTime = randList_nElements(42:90)(1);          % 7 am - 3 pm
                        endTime = startTime+12;                        % 2 hours gap
                        printf("Course=%d \t Quarter=%d \t Day=%d \n startTime=%d \t endTime=%d\n", Courses(c), quarters(q), days(d), startTime, endTime);
                endfor
        endfor
endfor
%}

function [retval] = randList_nElements(list)
        randomIndex = ceil(rand(1)*length(list));
        listRanomized = list(randperm(length(list)));
        retval = listRanomized(1:randomIndex);
endfunction
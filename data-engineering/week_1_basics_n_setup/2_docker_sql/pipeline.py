# this is our data pipeline and in this data pipeline we use pandas


import sys

import pandas as pd

print("what will be sys arg",sys.argv)

day = sys.argv[1]
  
# some practice with pandas
# 1
# print("job finished successfully")

# now we copy this file from current directory to docker image
# we can also specify the working directory

# 2
print(f"job finished successfully for day = {day}")

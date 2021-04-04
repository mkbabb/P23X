import random

nums = [random.randrange(0, 100) for _ in range(4)]

pos = 0
jmped = False

if (nums[0] > nums[pos]):
    pos = 0
if (nums[1] > nums[pos]):
    pos = 1
if (nums[2] > nums[pos]):
    pos = 2
if (not jmped and nums[3] > nums[pos]):
    pos = 3
if jmped:
    pass
    ## mul nums[pos]

max_num = nums.pop(pos)
# put into ax
jmped = True
## goto line 5


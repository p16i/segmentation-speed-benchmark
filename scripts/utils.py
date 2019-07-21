import time

def count_lines(path):
    with open(path, "r") as fin:
        total_lines = 0
        for l in fin:
            total_lines += 1
    return total_lines

class Timer:
    def __init__(self, algo, filepath):
        print("Tokenizing %s with %s" % (filepath, algo))

    def __enter__(self):
        self.start = time.time()

    def __exit__(self, type, value, traceback):
        self.stop = time.time()
        diff = (self.stop - self.start) # in secs
        print("time-took(secs) %.4f" %  (diff))
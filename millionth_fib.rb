# https://www.codewars.com/kata/53d40c1e2f13e331fc000c26
require 'matrix'
def fib(n)
  # https://blog.csdn.net/benert/article/details/76785221
  (Matrix[[1,0]]*Matrix[[1,1],[1,0]]**n).element(0,1)
end
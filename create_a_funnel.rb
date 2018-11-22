# https://www.codewars.com/kata/585b373ce08bae41b800006e
class Funnel
    # coding and coding...
    def initialize
      # 记录插入元素数量
      @count = 0
      # a1-a5存储自下至上的元素
      @arr = {}    
      # 初始赋值为" ",方便打印
      5.downto(1) {|x| @arr["a#{x}"] = Array.new(x," ") } 
      # 需要打印的数组
      @print_arr = init_print_arr
    end
    
    def fill *args
      # 边界情况退出
      return if @count == 15 || args.nil?
      # 传入数组扁平化处理
      args.flatten.each do |p|
        # 装满退出
        break if @count == 15
        # 寻找自下至上第一个可存储位置
        i = 1.upto(5).detect {|x| @arr["a#{x}"].include?(" ") }
        j = @arr["a#{i}"].index " "
        @arr["a#{i}"][j] = p
        @count += 1
      end 
      # 将数据同步打印数组
      fill_arr
    end
    
    def drip
      return if @count == 0
      rs = @arr["a1"][0]
      row = 1
      # 通过存储元素数量,判断当前深度
      case @count
        when 1
          row = 1
        when 2..3
          row = 2
        when 4..6
          row = 3
        when 7..10
          row = 4
        when 11..15
          row = 5
      end
      # 调整数组
      adjust row, row, 0, row-1   
      # 同步数组
      fill_arr
      @count -= 1
      rs
    end
    
    def to_s
      #　打印
      @print_arr.flatten.join
    end
    
    private
    # 初始化打印数组
    def init_print_arr
      arr = Array.new
      5.times do |x|
        arr << Array.new(11, " ")
        arr[x][x] = "\\"
        arr[x][10-x] = (x==4? "/" : "/\n") 
        10.downto(11-x) {|i| arr[x][i] = "" }
      end
      arr
    end
    # 同步打印数组
    def fill_arr
      @print_arr.each_with_index do |e, i|
        (5-i).times do |j|
          e[i+2*j+1] =  @arr["a#{5-i}"][j] 
        end
      end
    end
    # 递归调整
    # tol:当前深度;
    # row:递归状态下深度;
    # col:偏移下标;
    # ed:递归状态下最上层最后一个元素下标
    def adjust tol, row, col, ed
      if row == 1
        @arr["a#{tol}"][col] = " "
        return
      end
      if @arr["a#{tol}"][col] == " "
        if @arr["a#{tol}"][ed] == " "
          @arr["a#{tol-row+1}"][col] = @arr["a#{tol-row+2}"][col]
          adjust tol, row-1, col, ed-1
        else
          @arr["a#{tol-row+1}"][col] = @arr["a#{tol-row+2}"][col+1]
          adjust tol, row-1, col+1, ed
        end
      else
        @arr["a#{tol-row+1}"][col] = @arr["a#{tol-row+2}"][col]
        adjust tol, row-1, col, ed-1
      end
    end
  end
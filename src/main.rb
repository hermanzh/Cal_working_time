#! /usr/bin/ruby

require 'ld'
require 'date'
require 'time'

file = ARGV[0]

$date_data = {}
$result_date = {}

def precheck(file)
  unless File.exist? file.to_s
    puts <<HERE
Please check your input file!
Usage: calTime .../your_2003_excel_file.xls
HERE
    exit 0
  end
end

def format_date(date)
  date.strftime("%Y-%m-%d %T")
end

def read_excel file
  excel = Ld::Excel.open file
  arrs = excel.read('Sheet1?a1:b100000')

  arrs.each do |arr|
   unless arr[0].nil?
    day = arr[1].strftime("%Y-%m-%d")
    date = format_date(arr[1])
    if $date_data.has_key? day
      $date_data[day] << date
    else
      $date_data[day] = [date]
    end
   end
  end
end

def print_warn(day, time)
  puts "Warning: #{day} has only one data(#{time}), can't determine!"
end

def to_hour(time)
  (time/3600).round(2)
end

def cal_time
    total_time = 0.0
    days = 0
    $date_data.sort.each{ |day, date_arr|
      if date_arr.size == 1
        print_warn(day, date_arr[0])
      else
        date_arr.sort!
        time = (Time.parse(date_arr[-1]) - Time.parse(date_arr[0]))
        total_time += time
        $result_date[day] = to_hour(time)
        days += 1
      end
    }
    print_detail
    puts '-------------------------------------'
    puts "Total Time: #{to_hour(total_time)} hours"
    puts "Total Day: #{days} days"
end

def print_detail
  $result_date.each{ |d, h|
    puts "#{d} => #{h}h"
  }
end


precheck file
read_excel file
cal_time

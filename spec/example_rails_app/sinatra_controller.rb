class SinatraController < ApplicationController

  def 
    haml(:index)
    123.to_s
    puts("haha")
  end
  
  def dupa
    haml(:dupa)
    puts((12 ** 2))
  end
  
end

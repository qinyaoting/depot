class SayController < ApplicationController
  def hello
    @files = Dir.glob('*')
  end

  def goodbye
  end
end

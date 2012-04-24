class HomeController < ApplicationController

  def index
    @branches = Branch.all
  end
end

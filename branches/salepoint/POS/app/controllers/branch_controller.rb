class BranchController < ApplicationController
  def branch
    @branches = Branch.all
  end
  
  def add
    @branch = Branch.new(params[:product])
    
    if @product.save
      redirect_to :action => 'branch'
    else
      redirect_to :action => 'new'
    end
  end
end

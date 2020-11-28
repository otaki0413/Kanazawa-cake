class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  
  # マイページ
  def index
  end
  
  def edit
  end
  
  def update
  end
  
  def unsubscribe
  end
  
  def retire
  end
end

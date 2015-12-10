class CubesController < ApplicationController

  skip_before_filter :verify_authenticity_token


  def create_cube
    params = cube_params
    @cube = SetCube.new({:name => params[:name]})
    if @cube.save
      shared_cube = {:user_id => params[:user_id], :set_cube_id => @cube.id, :is_shared => false}
      @shared_cube = SharedCube.new(shared_cube)
      if @shared_cube.save
        render json: {:message => "Cube Created", :id => @cube[:id]}, status: :ok and return
      end
    end
    render json: {:message => "Cube Could not be Created"}, status: 422
  end

  def add_content
    @content = Content.new({:set_cube_id => params[:cube_id], :link => params[:link]})
    if @content.save
      render json: {:message => "Content Created", :id => @content[:id]}, status: :ok
    else
      render json: {:message => "Content Could not be Created"}, status: 422
    end
  end

  def remove_content
    @content = Content.find_by_id(params[:id])
    if @content
      if @content.destroy

        render json: {:message => "Content Deleted", :id => @content[:id]}, status: :ok
      else 
        render json: {:message => "Content Could not be Deleted"}, status: 422
      end
    else
      render json: {:message => "Content does not exist"}, status: 404
    end
  end
  

  def delete_cube
    @cube = SetCube.find_by_id(params[:id])
    if @cube
      if @cube.destroy
        render json: {:message => "Cube Deleted", :id => @cube[:id]}, status: :ok
      else 
        render json: {:message => "Cube Could not be Deleted"}, status: 422
      end
    else
      render json: {:message => "Cube does not exist"}, status: 404
    end
  end

  def share_content
    @content = Content.find_by_id(params[:id])
    if @content
      @cube = SetCube.find_by_id(@content.set_cube_id)
      shared_content = {:user_id => params[:user_id], :content_id => @content.id, :set_cube_id => @cube.id}
      @sc = SharedContent.new(shared_content)
      if @sc.save
        render json: {:message => "Content shared"}, status: 200
      else
        render json: {:message => "Content Could not be shared"}, status: 422
      end
    else
      render json: {:message => "Content does not exist"}, status: 404
    end
  end

  def share_cube
    @cube = SetCube.find_by_id(params[:id])
    if @cube
      shared_cube = {:user_id => params[:user_id], :set_cube_id => @cube.id, :is_shared => true}
      @shared = SharedCube.new(shared_cube)
      if @shared.save
        render json: {:message => "Cube Shared", :id => @cube[:id]}, status: :ok
      else 
        render json: {:message => "Cube Could not be shared"}, status: 422
      end
    else
      render json: {:message => "Cube does not exist"}, status: 404
    end
  end

  def list_all_cubes
    @all_cubes = []
    @cubes = SharedCube.all
    if @cubes.present?
      @cubes.each do |cube| 
        @all_cubes << {:cube_id => cube.set_cube_id, :user_id => cube.user_id, :is_shared => cube.is_shared}
      end

    end
    render json: {:cubes => @all_cubes}, status: :ok
  end

  def get_cubes_for_user
    cubes = []
    @cubes = SharedCube.where(:user_id => params[:id])
    if @cubes.present?
      @cubes.each do |cube| 
        cubes << {:cube_id => cube.set_cube_id, :user_id => cube.user_id, :is_shared => cube.is_shared}
      end
    end
    render json: {:cubes => cubes}, status: :ok
  end

  def get_content_for_user
    content = []
    @cubes_shared = SharedCube.select(:set_cube_id).where(:user_id => params[:id])
    @content = Content.where(:set_cube_id => @cubes_shared)
    @content_shared = SharedContent.where(:user_id => params[:id])

    if @content.present?
      @content.each do |cube| 
        content << {:content_id => cube.id, :user_id => params[:id], :parent_cube => cube.set_cube_id}
      end
    end

    if @content_shared.present?
      @content_shared.each do |con| 
        content << {:content_id => con.content_id, :user_id => con.user_id, :parent_cube => con.set_cube_id}
      end
    end
    render json: {:content => content}, status: :ok
  end
  

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def cube_params
      params.require(:cube).permit(:user_id,:name)
    end

end

class FiguresController < ApplicationController
require 'pry'
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    # , :title_ids => params[:figure][:title_ids], :landmark_ids => [:figure][:landmark_ids])
    # binding.pry
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
      @figure.save
      redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])


    if !params[:landmark][:name] == nil
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name] == nil
      @figure.titles << Title.create(params[:title])
    end

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

end

class NewhirecreditsController < ApplicationController
	
  layout "precredentialing"

  def index
	  @newhire = Newhire.find(params[:newhire_id])
      @newhirecredits = Newhirecredit.new
      @newhireinstitutions = Newhireinstitution.all
      @newhire_credits_added  = Newhirecredit.where(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
      
      
      #Tally total credis
      @total_credits=0.0
       if @newhire_credits_added.count > 0
         @newhire_credits_added.each do |idx|
            if idx.semester_credits == 1
              #calculate semester hours
              @total_credits = @total_credits + idx.course_credits.to_f
            else
              #calculate quarter hours
              @total_credits = @total_credits + (idx.course_credits.to_f * 2.0) / 3.0
            end
         end
      end

      @newhirecourses = Newhirecourse.where(:newhire_id => params[:id], :course_id => params[:course_id])   
      @newhire_dept = Department.find(@newhire.department_id) 
      @newhire_course_to_review = Newhirecourse.find(params[:course_id])

      #render :layout => 'simple'
    end

    def edit
      @newhire = Newhire.find(params[:newhire_id])
      @newhirecredits = Newhirecredit.find(params[:id])
      @newhireinstitutions = Newhireinstitution.all
      @newhire_dept = Department.find(@newhire.department_id)
    end

    def update
      @newhirecredits = Newhirecredit.find(params[:id])

      if ( params[:newhirecredit][:course_name].blank? ||
             params[:newhirecredit][:course_description].blank? ||
             params[:newhirecredit][:course_year].blank? ||
             params[:newhirecredit][:newhireinstitution_id].blank? ||
             params[:newhirecredit][:course_credits].blank? ||
             params[:newhirecredit][:semester].blank?
            )
      
          flash[:alert] = 'Please fill out all fields'
          redirect_to newhirecredits_path(:newhire_id => params[:newhire_id], :course_id => params[:course_id]) 
      else
          if @newhirecredits.update_attributes(params[:newhirecredit])
           flash[:notice] = "Coursework successfully updated."
        	else
           flash[:alert] = "There was a problem updating the coursework."
        	end

          redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
      end
      	
    end 

    def new
    	
    	if (params.has_key?(:newhire_id))
        	session[:newhire_id] = params[:newhire_id]
   		end

   		@newhire = Newhire.find(params[:newhire_id])
    	@newhirecredits = Newhirecredit.new
    	@newhireinstitutions = Newhireinstitution.all
    	@newhirecourses = Newhirecourse.where(:newhire_id => params[:id])   
        @newhire_dept = Department.find(@newhire.department_id) 
    end

    def destroy
	    @newhirecredits = Newhirecredit.find(params[:id])
	    @newhirecredits.destroy

	    #respond_to do |format|
	    #  format.html { redirect_to newhirecredentials_url }
	    #  format.json { head :ok }
	    #end

	    redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
	  end

    def create

    	if (params[:commit] == 'Add') 
	    	#@newhirecredit = Newhirecredit.new(params[:newhirecredits])
	    		if ( params[:newhirecredit][:course_name].blank? ||
	    			 params[:newhirecredit][:course_description].blank? ||
	    			 params[:newhirecredit][:course_year].blank? ||
	    			 params[:newhirecredit][:newhireinstitution_id].blank? ||
	    			 params[:newhirecredit][:course_credits].blank? ||
             params[:newhirecredit][:semester].blank?
	    			)
	    			 flash[:alert] = 'Please fill out all fields'
	    			 
	    			  #if (params.has_key?(:source))
					  #	redirect_to new_newhirecredit_path(:newhire_id => params[:id])
					  #else
					  #	redirect_to newhirecredits_path
					  #end

					redirect_to newhirecredits_path(:newhire_id => params[:newhire_id], :course_id => params[:course_id]) 
          #render :action => 'index', :newhire_id => params[:newhire_id], :course_id => params[:course_id]

	    		else
	    	 	  @newhirecredit   = Newhirecredit.new(params[:newhirecredit])
  			 	  @newhirecredit.newhire_id =  params[:newhire_id]
  			 	  @newhirecredit.course_id = params[:course_id]

			  	  if @newhirecredit.save
				    
				    #@newhirecredits_added = Newhirecredit.where(:newhire_id => session[:newhire_id])
				    flash[:notice] = "Relevant course added."
				  else
				   	flash[:alert] = "There was a problem saving the relevant coursework."		    
				  end

				  if (params.has_key?(:source))
				  	redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
				  else
				  	#redirect_to newhirecredits_path(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
				  	redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id] , :id => params[:course_id])
				  end

				end

	    else
	    	#redirect_to newhirecomment_index_path
	    	#redirect_to newhiredetails_path(:newhire_id => params[:newhire_id])
	    	redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id] , :id => params[:course_id])
		end
    end
end

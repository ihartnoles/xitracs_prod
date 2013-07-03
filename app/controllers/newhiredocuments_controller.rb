class NewhiredocumentsController < ApplicationController
  protect_from_forgery :except => :save_verified_doc
  layout "precredentialing"

  def index
  	#@newhire = Newhire.find(session[:newhire_id])
    @newhire = Newhire.find(params[:newhire_id])

    @newhiredocument = Newhiredocument.new
  	@newhiredoctypes = Newhiredoctype.new
    #@newhire_docs_added = Newhiredocument.where(:newhire_id => session[:newhire_id])
    @newhire_docs_added = Newhiredocument.where(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
    @newhirecourse = Newhirecourse.new
    @newhire_dept = Department.find(@newhire.department_id)
    #render :layout => 'simple'
  end

  def save_verified_doc
     @newhiredocument = Newhiredocument.find(params[:id])
     @newhiredocument.verified= params[:verified]
     @newhiredocument.save

     if @newhiredocument.save
       if params[:verified] == "1"
        flash[:notice] = "Document verified!"
       else
        flash[:notice] = "Document unconfirmed!"
       end
     else
       flash[:notice] = "There was a problem verifying the document."
     end
     
     render :nothing => true     
  end

  def create
 	if !params[:newhiredoctype_ids].nil?
	  	params[:newhiredoctype_ids].split(",") do |idx|
	  		@newhiredocument = Newhiredocument.new(:newhiredoctype_id => idx, :newhire_id => session[:newhire_id])
	  		@newhiredocument.save

	  		if @newhiredocument.save
	  			flash[:notice] = "Documents submitted have been saved."
	  		else
	  			flash[:notice] = "There was a problem saving Documents"
	  			#redirect_to newhiredocuments_path
	  		end 
	  	end	
	 else
	 	flash[:notice] = "No Docs have been submitted!"
	 	#redirect_to newhiredocuments_path
	 end


	 #if params[:upload_docs] == 'Yes'
	 #	redirect_to '/newhiredocuments/uploadform'
	 #else
	 	#TO DO: redirect to instructor credential radio boxes
	 	redirect_to newhirecredentials_path
	 #end

  end 

  def edit
    #@newhire = Newhire.find(params[:id])
    @newhire =Newhire.find(params[:newhire_id])
    @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])
    @newhiredocument = Newhiredocument.find(params[:id])
    @doc_type = params[:doc_type]
    @docname  = Newhiredoctype.find(params[:doc_type]).name

    if (params.has_key?(:source))
      render :layout => 'simple'
    end
  end

  def uploadform
  	@doc_type = params[:doc_type]
  	@docname  = Newhiredoctype.find(params[:doc_type]).name

    if !params[:newhire_id].blank?
      session[:newhire_id] = params[:newhire_id]
  	end

    render :layout => 'simple'
  end

  def file_download
     download = Newhiredocument.find(params[:doc_id])

     #send_file("#{Rails.root}/public/data/John_Jimmy_9/transcript/LoremIpsum.txt")

     #send_file("#{Rails.root}/#{download.location}")
     send_file("/#{download.location}")
  end

  #TO DO
  def term_degree_download
      send_file( "#{Rails.root}/public/data/Terminal+Degrees+by+Department.pdf", :type => 'application/pdf', :disposition => 'inline' )
  end

  def file_upload
       	#doctype = params[:file_upload][:doc_type]
        # get the file name
        name = params[:file_upload][:filename].original_filename

        #gather new hire info
        #newhirelname = Newhire.find(session[:newhire_id]).last_name
        #newhirefname = Newhire.find(session[:newhire_id]).first_name
        #newhireid    = Newhire.find(session[:newhire_id]).id

        newhirelname = Newhire.find(params[:newhire_id]).last_name
        newhirefname = Newhire.find(params[:newhire_id]).first_name
        dir_name     = newhirelname + "_" +newhirefname
        dir_name.gsub!(/[^0-9A-Za-z.\-]/, '_')
        newhireid    = Newhire.find(params[:newhire_id]).id
        courseid     = params[:course_id]
        
        #determine doc type
        doctype     = params[:doc_type]
         case doctype
            when '1' then doctypedir = 'transcript'
            when '2' then doctypedir = 'evaluation'
            when '3' then doctypedir = 'cv'
            when '4' then doctypedir = 'syllabus'
            when '5' then doctypedir = 'offerletter'
         end 
       
        #set the dynamic directory name
        dir = "/public/data/#{dir_name}_#{newhireid}/course_#{courseid}/#{doctypedir}"
        
        #create the file path
        path = File.join(dir, params[:file_upload][:filename].original_filename)
        

        FileUtils.rm_rf(dir)

        #create the directory if it doesn't exist
        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)                  
        end 
              

        # write the file
        File.open(path, "wb") { |f| f.write(params[:file_upload][:filename].read) }
        


        #determine if we are uploading a new syllabus or replacing an existing
        #check against course_id, semester_id, & faculty_id
        find_existing_docs = Newhiredocument.find(:first,:conditions => {:course_id =>params[:course_id],:newhiredoctype_id => params[:doc_type],:newhire_id => params[:newhire_id]})

        if !find_existing_docs.nil?
        #replace an existing document
          d = find_existing_docs
        else
            #upload a new doc
          d = Newhiredocument.new        
        end

        if (params[:commit] == 'Upload')
          
          #d = Newhiredocument.new
           #d.doc_type = params[:doc_type]
          d.name = name
          d.location = path
          d.newhiredoctype_id = params[:doc_type]
          #d.newhire_id = session[:newhire_id]
          d.newhire_id = params[:newhire_id]
          d.course_id = params[:course_id]
          d.save
        else
          @newhiredocument = Newhiredocument.find(params[:id])
          @newhiredocument.name = name
          @newhiredocument.location = path
          @newhiredocument.newhiredoctype_id = params[:doc_type]
          #@newhiredocument.newhire_id = session[:newhire_id]
          @newhiredocument.newhire_id = params[:newhire_id]
          @newhiredocument.course_id = params[:course_id]
          @newhiredocument.save
        end

       	flash[:notice] = "File has been uploaded successfully"

     	redirect_to newhiredocuments_uploadstatus_path
  end

  def show
  	render :layout => 'simple'
  end
end

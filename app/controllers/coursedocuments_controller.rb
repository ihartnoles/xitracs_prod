class CoursedocumentsController < ApplicationController


	def display_doc_form
	  	#@newhire = Newhire.find(params[:newhire_id])
      #@newhire_docs_added = Newhiredocument.where(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
      #@newhire_dept = Department.find(@newhire.department_id)

      #faculty_id    = Faculty.find_by_znumber(params[:znumber]).id
      #@section_ids = Sectionenrollment.where(:faculty_id => faculty_id).map {|row| row.section_id}
      
      @faculty = Faculty.find_by_znumber(params[:znumber])
      @course = Course.find(params[:course_id])

      render :layout => 'simple'
  	end


  	def file_upload
       	#doctype = params[:file_upload][:doc_type]
        # get the file name
        name = params[:file_upload][:filename].original_filename

        #gather faculty info
        facultylname = Faculty.find_by_znumber(params[:znumber]).last_name
        facultyfname = Faculty.find_by_znumber(params[:znumber]).first_name
        dir_name     = facultylname + "_" +facultyfname
        dir_name.gsub!(/[^0-9A-Za-z.\-]/, '_')
        facultyid    = Faculty.find_by_znumber(params[:znumber]).id
        courseid     = params[:course_id]
        sectionid    = params[:section_id]
        
       
        #set the dynamic directory name
        dir = "/public/data/course_syllabi/course_#{courseid}/section_#{sectionid}/#{dir_name}"
        
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
       	find_existing_docs = Coursedocument.find(:first,:conditions => {:course_id =>params[:course_id],:semester_id => session[:semester_id], :section_id =>params[:section_id], :faculty_id => facultyid})

       if !find_existing_docs.nil?
	      #replace an existing document
	      d = find_existing_docs

       else
       	  #upload a new doc
       	d = Coursedocument.new        
	     
	   end

	      # set paramaters and save
	      d.course_id = params[:course_id]
	      d.semester_id = session[:semester_id]
	      d.name = name
	      d.location = path
	      d.faculty_id = facultyid
        d.section_id = params[:section_id]
	      d.save

       	flash[:notice] = "File has been uploaded successfully"

     	redirect_to newhiredocuments_uploadstatus_path
  end

  def download_dialog
      @faculty = Faculty.find_by_znumber(params[:znumber])
      @course = Course.find(params[:course_id])

      render :layout => 'simple'
  end

  def file_download
     #download = Coursedocument.find(params[:doc_id])
     facultyid    = Faculty.find_by_znumber(params[:znumber]).id
     download    = Coursedocument.where(:course_id => params[:course_id], :semester_id => session[:semester_id], :section_id =>params[:section_id], :faculty_id => facultyid).map { |row| row.location }.join(",")
     #download.gsub!(/[^0-9A-Za-z.\-]/, '_')
     
    if download.blank?
      flash[:notice] = "The file you are trying to download has not been uploaded or is not available"
      redirect_to download_dialog_path
    else
      send_file("#{download}")
    end
    
  end

end

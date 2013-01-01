require 'hashie'
module Canvas
  class Client
    # Defines methods related to enrollments
    module Enrollments

      # Create a new user enrollment for a course
      # 
      # @overload enroll_in_course(course_id, user_id, options={})
      #   @param course_id [Integer] A Canvas course ID
      #   @param user_id [String] The user_id for the user
      #   @option options [String] :type Enroll the user as a student|teacher|etc.
      #   @option options [String] :enrollment_state If 'active', student is immediately enrolled in course. Defaults to 'invited'
      #   @option options [String] :course_section_id The ID of the course section to enroll the student in
      #   @option options [Boolean] :notify If false (0 or “false”), a notification will not be sent to the enrolled user. Notifications are sent by default
      #   @option options [Boolean] :sis_course If true, treats course_id param as an sis_course_id
      #   @option options [Boolean] :sis_user If true, treats user_id param as an sis_user_id
      #   @example Creates a new enrollment in course ID 5 for user with user ID '1324'
      #     Canvas.enroll_in_course(5, 1324,
      #                             :type => 'active',
      #                             :notify => "false")
      # @format :json
      # @see TODO:docs url
      def enroll_in_course(course_id, user_id, options={})
        h = Hashie::Mash.new
        h.enrollment!
        h.enrollment!.user_id = user_id
        h.enrollment!.type = options[:type] if options[:type] # defaults to 'StudentEnrollment'
        h.enrollment!.enrollment_state = options[:enrollment_state] if options[:enrollment_state] # defaults to to 'invited'
        h.enrollment!.course_section_id = options[:course_section_id] if options[:course_section_id]
        h.enrollment!.notify = options[:notify] if options[:notify] # defaults to "true"
        
        if options[:sis_course] == true
          sis_course_id = course_id.unpack("H*")[0]
          course_id = "hex:sis_course_id:#{sis_course_id}"
        end
        if options[:sis_user] == true
          h.enrollment!.user_id = "sis_user_id:#{user_id}"
        end
        response = post("courses/#{course_id}/enrollments", h)
        response
      end

      def enroll_in_section
        # POST sections/:section_id/enrollments
      end

      def list_user_enrollments
        # GET users/:user_id/enrollments
      end

      def list_course_enrollments
        # GET courses/:course_id/enrollments
      end

      def list_section_enrollments
        # GET sections/:section_id/enrollments
      end

      def conclude_enrollment
        # DELETE courses/:course_id/enrollments/:id
      end
      
    end
  end
end
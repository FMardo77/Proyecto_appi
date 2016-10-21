class Task < ActiveRecord::Base
	# Relations
	belongs_to :user
	# Validations
	validates(:title, { presence: true, length: {in: 1..255}, uniqueness: true})
	# Function/Action
	# def complete
	# 	self.complete = true
	# end
	# Callbacks
	# before_save
	# after_save
	# before_destroy
	# after_destroy
	before_save(:check_title)
	after_destroy :print_all_tasks

	def check_title
		puts "Entré a before_save"
		if self.title.nil? or self.title.empty?
			self.title = 'Tarea nueva'
		end
	end

	# validate :check_if_complete

	# def check_if_complete
	# 	if self.complete == true
	# 		errors.add(:complete, "can't create a completed task")
	# 	end
	# end

	def print_all_tasks
		puts "Entré a after_destroy"
		puts Task.all.count
	end

	# Attributes
	# title:string
	# complete:boolean
end

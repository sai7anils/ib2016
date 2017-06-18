# == Schema Information
#
# Table name: entrepreneurs
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  first_name            :string
#  last_name             :string
#  dob                   :date
#  gender                :boolean
#  profession_type       :integer
#  profession_company    :string
#  profession_skill      :integer
#  profession_experience :integer
#  graduation            :string
#  university            :string
#  mobile                :string
#  address               :string
#  website               :string
#  email_second          :string
#  about                 :text
#  inspire_quote         :text
#  linkedin              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  skype                 :string
#

class Entrepreneur < ActiveRecord::Base
  belongs_to :user
  GRADUATIONS = [["- Select Graduation -", nil], ["UnderGraduate", 1], ["PostGraduate", 2], ["Phd", 3], ["Others", 4]]
  GRADUATIONSINFO = [["No Information", nil], ["UnderGraduate", 1], ["PostGraduate", 2], ["Phd", 3], ["Others", 4]]

  def pro_type_name
    EntrepreneurType.find(self.profession_type).name rescue nil
  end

  def pro_skill_name
    ProfessionalSkill.find(self.profession_skill).name rescue nil
  end

  def graduation_name
    GRADUATIONS[self.graduation.to_i].first
  end

  def graduation_info
    GRADUATIONSINFO[self.graduation.to_i].first
  end

  def linkedin_name
    self.linkedin.split('/').last unless self.linkedin.nil?
  end

  def self.by_profession_type(users,profession_type)
    users.where("profession_type=?", profession_type)
  end

  def self.by_skill(users, skill)
    users.where("profession_skill=?", skill)
  end

  def self.year_options
    [["- Select Age -", nil]].concat((1900..2009).collect{|y| "#{y}" })
  end

  def self.gender_options
    [["- Select Gender -", nil], ["Male", true], ["Female", false]]
  end

  def self.graduation_options
    GRADUATIONS
  end

  def self.pro_skill_options
    [["- Select Skill -", nil]].concat(ProfessionalSkill.all.collect {|p| [ p.name, p.id ] })
  end

  def self.pro_exp_options
    [["- Startup Experience -", nil]].concat((0..9).collect{|y| ["#{y} years", y] })
  end

  def self.pro_type_options
    [["- Profession Type -", nil]].concat(EntrepreneurType.all.collect {|p| [ p.name, p.id ] })
  end

  def self.search(params)
    results = all
    if params[:query].present?
      results = results.joins(:user).where("users.username LIKE :query OR users.email LIKE :query", query: "%#{params[:query]}%")
    end
    if params[:location].present?
      results = results.joins(:user).where("users.country LIKE :location OR users.city LIKE :location OR users.region LIKE :location", { location: "%#{params[:location]}%" })
    end
    if params[:gender].present?
      results = results.where(gender: params[:gender])
    end
    if params[:dob].present?
      dob = Date.parse(params[:dob]) rescue nil
      results = results.where(dob: params[:dob]) if dob
    end
    if params[:profession_type].present?
      results = results.where(profession_type: params[:profession_type])
    end
    if params[:profession_company].present?
      results = results.where("profession_company LIKE ?", "%#{params[:profession_company]}%")
    end
    if params[:profession_skill].present?
      results = results.where(profession_skill: params[:profession_skill])
    end
    if params[:profession_experience].present?
      results = results.where(profession_experience: params[:profession_experience])
    end
    if params[:university].present?
      results = results.where("university LIKE ?", "%#{params[:university]}%")
    end
    if params[:address].present?
      results = results.where("address LIKE ?", "%#{params[:address]}%")
    end
    results
  end

end

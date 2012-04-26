#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'httparty'

build_status_url = ENV['BUILD_STATUS_URL']
jenkins_json = HTTParty.get ENV['JENKINS_API_URL']
builds = jenkins_json['jobs']

builds.each do |build|
  build_name = build['name']
  url = build['url']

  build = HTTParty.get url + "api/json"

  last_stable_url = build['lastStableBuild']['url']
  build_result = HTTParty.get last_stable_url + 'api/json'

  branch = build_result['actions'].detect{|a| a.has_key?('lastBuiltRevision') }['lastBuiltRevision']['branch'].first
  branch_name = branch['name']
  sha = branch['SHA1']
  result = build_result['result']

  HTTParty.post(build_status_url,
                  :body => {:payload => {:branch => branch_name,
                  :revision_id => sha, :build_name => build_name,
                  :result => result}.to_json})
end


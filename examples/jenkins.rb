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

  last_build = build['lastBuild']
  next unless last_build

  last_stable_url = last_build['url']
  build_result = HTTParty.get last_stable_url + 'api/json'

  last_build_action = build_result['actions'].detect{|a| a.has_key?('lastBuiltRevision') }
  next unless last_build_action
  branch = last_build_action['lastBuiltRevision']['branch'].first
  branch_name = branch['name']
  sha = branch['SHA1']
  result = build_result['result']
  duration = build_result['duration']

  HTTParty.post(build_status_url,
                :body => {:payload => {:branch => branch_name,
                                       :revision_id => sha, :build_name => build_name,
                                       :duration => duration,
                                       :result => result}.to_json})
end


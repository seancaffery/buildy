class BuildUpdater
  def update_with(build_info)
    branch = Branch.find_or_create_by_name(build_info['branch'].gsub('/', '_'))
    build = branch.builds.find_by_name(build_info['build_name'])

    return false unless build

    revision = branch.revisions.find_or_create_by_sha(build_info['revision_id'])
    return update_result(build, revision, build_info)
  end

  def update_result(build, revision, build_info)
    build_result = revision.build_results.find_or_create_by_revision_id_and_build_id(revision.id, build.id)
    build_result.result = build_info['result']
    build_result.build_time = build_info['duration']
    build_result.save
  end
end

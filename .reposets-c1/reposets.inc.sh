#!/bin/bash
#
# Sources a reposet that belongs to the given parameter. If no parameter is given, the reposet named
# '.reposet' will be sourced.
# Also contains helper functions to use the mapping.
#
# author: andreasl

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
reposet_file="${script_dir}/${1}.reposet"

if [ ! -f "$reposet_file" ] ; then
    >&2 printf "Expected existing reposet file at \"${reposet_file}\" but found none."
    exit 1
fi

source "${script_dir}/${1}.reposet"

# sanity check reposet is not null
if [ "${#repo_paths2default_branch_names[@]}" == 0 ] ; then
    output="Error in ${BASH_SOURCE[0]} sourced by ${0}: dictionary"
    output="${output} '\$repo_paths2default_branch_names' seems to be empty. Is the reposet"
    output="${output} correct?"
fi

# sanity check each reposet entry has correct size
n_errors=0
for repo in "${!repo_paths2default_branch_names[@]}"; do
        branch_names_string="${repo_paths2default_branch_names[${repo}]}";
        IFS=',' read -r -a branch_names <<< "${branch_names_string}"

        if [ ${#branch_names[@]} != 3 ] ; then
            output="Error in ${BASH_SOURCE[0]} sourced by ${0}: Repo ${repo}'s branch names array"
            output="${output} is malformed: ${branch_names[*]}. It should contain exactly 3"
            output="${output} branches in the form (local,remote pull, remote push), but does not."
            >&2 printf "${output}\n"
            n_errors=$((n_errors + 1))
        fi
done
if [ "$n_errors" -gt 0 ] ; then
    exit "$n_errors"
fi

# utility functions
function local_branch {
    # Given a repo path, retrieves its local default branch.
    # Usage:
    #  local_branch <repo-path>
    local branches_string="${repo_paths2default_branch_names[${1}]}";
    IFS=',' read -r -a branches <<< "${branches_string}"
    echo "${branches[0]}"
}

function remote_pull_branch {
    # Given a repo path, retrieves its default remote pull branch.
    # Usage:
    #  remote_pull_branch <repo-path>
    local branches_string="${repo_paths2default_branch_names[${1}]}";
    IFS=',' read -r -a branches <<< "${branches_string}"
    echo "${branches[1]}"
}

function remote_push_branch {
    # Given a repo path, retrieves its default remote push branch.
    # Usage:
    #  remote_push_branch <repo-path>
    local branches_string="${repo_paths2default_branch_names[${1}]}";
    IFS=',' read -r -a branches <<< "${branches_string}"
    echo "${branches[2]}"
}

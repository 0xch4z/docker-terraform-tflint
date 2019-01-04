#!/usr/bin/env python

import os
import requests


def get_latest_release():
  print('[*] fetching latest release...')
  headers = {}
  gh_token = os.getenv('GITHUB_API_TOKEN')
  if gh_token:
    headers['Authorization'] = 'token {}'.format(gh_token)
  res = requests.get('https://api.github.com/repos/HashiCorp/Terraform/releases', headers=headers)
  return res.json()[0].get('tag_name').replace('v', '')


def get_artifact_sum(version):
  print('[*] fetching latest hash sums...')
  uri = 'https://releases.hashicorp.com/terraform/{0}/terraform_{0}_SHA256SUMS'.format(version)
  sums = requests.get(uri).text.strip().split()
  linux_amd64_entry = (i for i, v in enumerate(sums) if 'linux_amd64' in v)
  return (sums[next(linux_amd64_entry) - 1], uri,
    'https://releases.hashicorp.com/terraform/{0}/terraform_{0}_linux_amd64.zip'.format(version))


if __name__ == '__main__':
  semver = get_latest_release()
  hash_sum, sums_uri, artifact_uri = get_artifact_sum(semver)
  print("""
  latest release:
    v{}
  
  latest linux_amd64 build artifact:
    {}

  latest sha256 hash sums:
    {}
  
  latest linux_amd64 sha256 hash sum:
    {}
  """.format(semver, artifact_uri, sums_uri, hash_sum))

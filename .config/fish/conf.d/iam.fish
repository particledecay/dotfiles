function iam_enable
  set target $argv[1]
  set -gx AWS_ACCESS_KEY_ID "(pass smiledirectclub/aws/{$target}/access_key_id)"
  set -gx AWS_SECRET_ACCESS_KEY "(pass smiledirectclub/aws/{$target}/secret_access_key)"
end

function iam_disable
  set -ge AWS_ACCESS_KEY_ID
  set -ge AWS_SECRET_ACCESS_KEY
end

script_path=$(dirname "$0")
echo "TEST"
echo $script_path
envsubst < $script_path/../Templates/Secret.swift > $script_path/../MIAapp/Secret.swift


cwd := invocation_directory()
role_dir := "roles"
playbook_dir := "playbooks"
verbose := ""

doc := '
  Usage: gen [command] [parameters]

  Generate files and directories from templates. Destination directories will
  be generated if they do not exist. Destination directories are evaluated to
  be under the current working directory when this is called by default, to
  change where destination paths are evaluated from, then you can set the `cwd`
  before the command that is invoked.

  Example setting cwd directory:

  `gen cwd=/foo repo bar`

  The above will create a repo from the template in /foo/bar

  Available Commands:
'
[private]
default:
  @just --list --list-heading '{{doc}}'

# Helper to run the playbook with the given tag and args.
_run tag *ARGS:
  #!/bin/sh
  if [ -n "{{verbose}}" ]; then
    echo "tag: {{tag}}, run args: {{ARGS}}" && \
    ansible-playbook ./main.yml --tags {{tag}} {{ARGS}}
  else
    ansible-playbook ./main.yml --tags {{tag}} {{ARGS}} 1> /dev/null
  fi

# Helper to run the playbook with the given name, destination, and tag.
_run-playbook name destination tag:
  @just _run {{tag}} \
    "--extra-vars project_name={{name}}" \
    "--extra-vars destination_dir={{destination}}"
  @echo "Created {{tag}} in {{destination}}"

# Generates a minimal ansible playbook repo directory named [name] in [cwd].
playbook-repo name: (_run-playbook
  name
  absolute_path(cwd / name)
  "playbook-repo"
)

# Generates a minimal ansible playbook named [name] in [destination defaults to 'playbooks/'].
playbook name destination=playbook_dir:
  @just _run playbook \
    "--extra-vars playbook_name={{name}}" \
    "--extra-vars destination_dir={{absolute_path(cwd / destination)}}"
  @echo "Created playbook {{name}} in {{absolute_path(cwd / destination)}}"

# Generates a minimal repo directory named [name] in [cwd].
repo name: (_run-playbook
  name
  absolute_path(cwd / name)
  "repo"
)

# Generates a minimal ansible role directory named [name] in [destination defaults to 'roles/'].
role name destination=role_dir:
  #!/bin/sh
  mkdir -p "{{cwd/destination/name}}/"{defaults,tasks}
  touch "{{cwd/destination/name}}/"{defaults,tasks}/main.yml
  echo "Created role {{name}} in {{cwd/destination}}"

# Pull updates from git.
update:
  @cd {{justfile_directory()}} && git pull


# ansible-gen-playbook

An ansible playbook that helps generate directory structures from templates.

## Installation

Clone this repository.

```bash
git clone https://github.com/m-housh/ansible-gen-playbook.git
```

The templates are ansible roles, located in the `roles/` directory of the
repository. You can customize them to your needs (generally better to create a
fork of this repository, if desired).

## Requirements

Requires [ansible](https://ansible.com) and
[just](https://github.com/casey/just) to be installed, see their respective
documentation for how to install.

This is meant for Unix / macOS style systems, windows is not supported
currently.

### Usage

The below command can be used to list the current commands / templates.

```bash
just --justfile <path-to-this-repo>/justfile
```

This style is pretty verbose, generally you would create an alias to point to
this repository.

```bash
# In your shell rc / environment / alias file.
export ANSIBLE_GEN_DIR=/path/to/this/repo
alias gen='just --justfile "$ANSIBLE_GEN_DIR/justfile"'
```

Then you can use like:

```bash
gen playbook-repo my-ansible-playbook
```

### See Available commands.

Running the justfile (or alias) without any commands or parameters will print
the available commands that can be ran.

Assuming the alias is setup as shown above, you can run the following, to get
the usage description.

```bash
gen
```

# LICENSE

This is licensed under the MIT license.

See [LICENSE](https://github.com/m-housh/ansible-gen-playbook/LICENSE) for
details.

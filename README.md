# WolfFlow Cookiecutter Template

[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![Cookiecutter](https://img.shields.io/badge/built%20with-Cookiecutter-ff69b4.svg)](https://github.com/cookiecutter/cookiecutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A [Cookiecutter](https://github.com/cookiecutter/cookiecutter) template for creating new WolfFlow projects. WolfFlow helps maintain context across AI assistant sessions, making development more efficient and consistent.

## What is WolfFlow?

[WolfFlow] is a framework that enhances AI-assisted development by maintaining persistent context across sessions. It allows AI assistants to:

- Remember previous conversations and decisions
- Access project-specific knowledge and configurations
- Adapt to different development modes (coding, architecture planning, debugging, etc.)
- Provide more consistent and relevant assistance

This template provides everything you need to quickly set up a new project with WolfFlow integration.

## Features

- **Configurable project structure** with WolfFlow integration
- **System prompts** for different AI assistant modes (code, architect, ask, debug, test)
- **Environment variable setup scripts** for Windows and Unix/Mac
- **Optional default mode configuration** for customized AI assistance
- **Optional memory bank templates** for persistent context
- **UVX integration support** for modern Python package management
- **Comprehensive documentation** for easy setup and customization

## Requirements

- Python 3.6+
- Cookiecutter (`pip install cookiecutter` or `uv pip install cookiecutter`)
- Optional: UVX (`pip install uv`) - A modern Python package installer and resolver

## Usage

### With pip (traditional)

```bash
# Install cookiecutter if you haven't already
pip install cookiecutter

# Create a new project from this template
cookiecutter gh:Opensourceful/WolfFlow-Cookiecutter
# or from local template
cookiecutter path/to/Wolfflow-cookiecutter
```

### With UVX (recommended)

```bash
# Install UVX if you haven't already
pip install uv

# Create a new project from this template
uvx cookiecutter gh:Opensourceful/WolfFlow-Cookiecutter
# or from local template
uvx cookiecutter path/to/Wolfflow-cookiecutter
```

## Configuration Options

When you run the template, you'll be prompted for these values:

| Option | Description | Default |
|--------|-------------|---------|
| `project_name` | Your project name | "My WolfFlow Project" |
| `project_slug` | URL-friendly name | Auto-generated from project_name |
| `project_description` | A short description | "A project using WolfFlow for persistent context and optimized AI-assisted development" |
| `author_name` | Your name | "Your Name" |
| `author_email` | Your email address | "your.email@example.com" |
| `license` | Choose a license | MIT, Apache-2.0, GPL-3.0, BSD-3-Clause |
| `include_default_mode` | Include default mode configuration | yes/no |
| `include_memory_bank_templates` | Include memory bank templates | yes/no |
| `use_uv` | Use UVX for Python package management | yes/no |


## Project Structure

The generated project will have this structure:

```
my-Wolfflow-project/
├── .Wolf/                  # System prompt files for different modes
├── .Wolfignore             # Files to ignore in context
├── .Wolfmodes              # Mode configuration
├── Wolf_config/            # Configuration files
│   ├── insert-variables.cmd  # Windows script to set environment variables
│   ├── insert-variables.sh   # Unix script to set environment variables
│   └── default-mode/      # Default mode configuration (if enabled)
│       ├── cline_custom_modes.json  # Custom modes configuration
│       ├── custom-instructions.yaml # Custom instructions
│       ├── README.md      # Documentation for default mode
│       └── role-definition.txt      # Role definition for default mode
├── memory-bank/           # Memory bank templates (if enabled)
│   └── README.md          # Documentation for memory bank
├── LICENSE                # Project license
├── CONTRIBUTING.md        # Contribution guidelines
└── README.md              # Project README
```

If you select UVX integration, these additional files will be created:

```
my-Wolfflow-project/
├── .uv/                   # UVX configuration directory
│   └── uv.toml            # UVX configuration file
├── uv-setup.cmd           # Windows UVX setup script
├── uv-setup.sh            # Unix/Mac UVX setup script
└── requirements.txt       # Python dependencies file
```

## Post-Generation

After generating the project:

1. Navigate to your new project directory
2. Run the appropriate script to set up your environment:
   - Windows: `Wolf_config/insert-variables.cmd`
   - Unix/Mac: `Wolf_config/insert-variables.sh`

This will configure the system prompts with your local environment details.

### UVX Setup (if selected)

If you chose to use UVX, you can set up your environment by running:
- Windows: `uv-setup.cmd`
- Unix/Mac: `./uv-setup.sh`

This will create a virtual environment and install any dependencies listed in `requirements.txt`.

## Default Mode Configuration

If you selected to include default mode configuration, your project will include a `Wolf_config/default-mode` directory with:

- `cline_custom_modes.json`: Configuration for custom AI assistant modes
- `custom-instructions.yaml`: Custom instructions for the AI assistant
- `role-definition.txt`: Role definition for the default mode
- `README.md`: Documentation for the default mode configuration

These files allow you to customize how the AI assistant behaves when working with your project.

## Memory Bank Templates

If you selected to include memory bank templates, your project will include a `memory-bank` directory. The memory bank is a feature that allows you to store and retrieve information across AI assistant sessions, helping maintain context and knowledge about your project over time.

To use the memory bank:
1. Add files to the `memory-bank` directory containing important project information
2. These files will be loaded into the AI's context when you start a new session

## Customization

You can customize the generated project by:

1. Editing the system prompt files in `.Wolf/`
2. Modifying the `.Wolfignore` file to control what files are included in context
3. Updating the `.Wolfmodes` file to add or remove modes
4. Customizing the default mode configuration in `Wolf_config/default-mode/`
5. Adding project-specific information to the memory bank


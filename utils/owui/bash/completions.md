# Ollama Bash Completion Script

This script providesbash autocompletion functionality for interacting with your Ollama instance, making command-line usage more efficient.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Requirements](#requirements)

## Installation

1. **Download/Clone the Script:**

   You can either download or clone this repository to your local machine:

   ```bash
   wget https://raw.githubusercontent.com/<username>/ollama-bash-completion/master/dxo_completion_script.sh -O ~/.dxo_completion_script.sh
   ```

2. **Make it Executable:**

   Ensure the script is executable by running:

   ```bash
   chmod +x ~/.dxo_completion_script.sh
   ```

3. **Source the Script (temporarily):**

   To temporarily load the completion script into your current shell, run:

   ```bash
   source ~/.dxo_completion_script.sh
   ```

4. **Add to Bashrc (permanently):**

   To make the completion script available in every new terminal session, add it to your `~/.bashrc` file:

   ```bash
   echo "source ~/.dxo_completion_script.sh" >> ~/.bashrc
   source ~/.bashrc
   ```

## Configuration

Before using this script, ensure that you have a running Ollama instance on your host. This script is configured to watch for an alias (`dxo`) of the command `docker exec -it ollama ollama`.

You can customize the Ollama instance or alias by modifying the following line in `~/.dxo_completion_script.sh`:

```bash
command="ollama"
```

## Usage

After installation and configuration, use this bash completion script as follows:

1. Navigate to your Ollama instance's directory.
2. Type the command prefix (`ollama`) followed by a space.
3. Press `<TAB>` for autocomplete suggestions (e.g., `ollama run <TAB>`).
4. Enter the desired command argument and press `<ENTER>`.

Enjoy faster and easier interaction with your Ollama instance!

---
![Google Groups](https://img.shields.io/badge/Google%20Groups-blue?style=flat-square&logo=Google&logoColor=white)
![Automation](https://img.shields.io/badge/Automation-darkorange?style=flat-square&logo=Automattic&logoColor=white)

# google-groups-scan
Automatically scans user accounts from /etc/passwd, checks for existing Maildir directories, and searches email messages for the X-Google-Group-ID header, extracting and displaying relevant Google Groups data.

<!-- TOC -->

- [google-groups-scan](#google-groups-scan)
    - [Features](#features)
    - [Use Cases](#use-cases)
    - [Configuration](#configuration)
    - [Getting Started](#getting-started)
        - [Prerequisites und required packages](#prerequisites-und-required-packages)
        - [Installation](#installation)
        - [Usage](#usage)
        - [Example Output](#example-output)
    - [Contributing](#contributing)
    - [License](#license)

<!-- /TOC -->

## Features
- Automate Google Groups management tasks
- Analyze Google Groups data
- Generate reports and statistics
- Save results to a file (configurable with `SAVE_RESULTS` variable)

## Use Cases
This tool can be used in various scenarios, including but not limited to:

- **Anti-Spam Filtering**: By analyzing the Google Groups data, you can identify which groups are receiving emails within your organization. This information can be used to create a whitelist of approved groups, helping to enhance your anti-spam filtering mechanisms.
- **Reporting and Auditing**: Perform in-depth analysis of email patterns, group usage, and communication trends to make informed decisions and improve collaboration within your organization.

## Configuration
You can configure the script by modifying the following parameters at the beginning of the script:
- `PASSWD_FILE`: Path to the passwd file (default: `/etc/passwd`)
- `MAILDIR_SUFFIX`: Suffix for Maildir directories (default: `/Maildir`)
- `SAVE_RESULTS`: Set to `true` to save results to a file, `false` otherwise (default: `true`)
- `RESULTS_FILE`: Name of the file to save results (default: `google_groups_results.txt`)

## Getting Started

### Prerequisites und required packages
- Unix-based operating system (Linux, macOS)
- `bash` shell
- `grep`
- `find`

For Debian-based distributions (e.g., Ubuntu):
```sh
sudo apt-get update
sudo apt-get install bash grep findutils
```

For Red Hat-based distributions (e.g., Fedora, CentOS):
```sh
sudo dnf install bash grep findutils
```

### Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/filipnet/google-groups-scan.git
    ```
2. Navigate to the project directory:
    ```sh
    cd google-groups-scan
    ```
3. Make the script executable:
    ```sh
    chmod +x analyze_google_groups.sh
    ```

### Usage
To use the script, run the following command:
```sh
./analyze_google_groups.sh
```

### Example Output

```plaintext
File: /home/max.mustermann/Maildir/.Junk/cur/1735830338.M742611P4027013.srv01,S=11776,W=11971:2,S
Google-Group-ID: X-Google-Group-Id: 639024413630
List-ID: List-ID: <bj.fvx.inojayapokermax.xyz>

File: /home/max.mustermann/Maildir/cur/1735224217.M800284P1697893.srv01,S=11501,W=11696:2,Sa
Google-Group-ID: X-Google-Group-Id: 639024413630
List-ID: List-ID: <foe.zis.ccuvana.name>
```

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue for any bugs or feature requests.

## License
google-groups-scan and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the [LICENSE](LICENSE).

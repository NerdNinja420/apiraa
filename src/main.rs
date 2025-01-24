use std::process::Command;

fn copy_to_system_clipboard(content: &str) -> bool {
    let command_input = format!("source {}", content);
    match Command::new("wl-copy").arg(command_input).status() {
        Ok(status) => status.success(),
        Err(e) => {
            eprintln!("Failed to execute wl-copy: {}", e);
            false
        }
    }
}

fn find_activate_file(bin_dir: &str) -> Option<String> {
    let find_activate_output = Command::new("find")
        .arg(bin_dir)
        .arg("-type")
        .arg("f")
        .arg("-name")
        .arg("activate")
        .output()
        .ok()?;

    if find_activate_output.status.success() {
        let activate_path = String::from_utf8_lossy(&find_activate_output.stdout)
            .trim()
            .to_string();
        if !activate_path.is_empty() {
            return Some(activate_path);
        }
    } else {
        eprintln!(
            "Error searching for activate in {}: {}",
            bin_dir,
            String::from_utf8_lossy(&find_activate_output.stderr)
        );
    }

    None
}

fn find_activate_script() -> Option<String> {
    let find_bin_output = Command::new("find")
        .arg(".")
        .arg("-type")
        .arg("d")
        .arg("-name")
        .arg("bin")
        .output()
        .ok()?;

    if !find_bin_output.status.success() {
        eprintln!(
            "Error running first find command: {}",
            String::from_utf8_lossy(&find_bin_output.stderr)
        );
        return None;
    }

    let bin_dirs = String::from_utf8_lossy(&find_bin_output.stdout);

    for bin_dir in bin_dirs.lines() {
        if let Some(activate_path) = find_activate_file(bin_dir) {
            return Some(activate_path);
        }
    }
    None
}

fn main() {
    if let Some(activate_script) = find_activate_script() {
        if copy_to_system_clipboard(&activate_script) {
            println!("Found Venv: copied the virtual enviroment path to system clipboard!");
        }
        println!("Command: source {}", activate_script);
    } else {
        println!("No virtual environment found.");
    }
}

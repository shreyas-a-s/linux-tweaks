#!/usr/bin/env bash

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Store version number of sudo into a variable
sudo_version=$(command sudo -V | grep "Sudo version" | awk '{print $NF}' | awk -F 'p' '{print $1}')

# Split the version numbers into arrays
IFS='.' read -ra sudo_version_array <<< "$sudo_version"

# Compare version of sudo with 1.9.6 (which is required for the next sudoers tweak to work)
compare_versions=$(awk -v sv1="${sudo_version_array[0]}" -v sv2="${sudo_version_array[1]}" -v sv3="${sudo_version_array[2]}" \
  'BEGIN{printf("%d\n", (sv1 > 1 || (sv1 == 1 && (sv2 > 9 || (sv2 == 9 && sv3 >= 6)))))}')

# Disable creation of ~/.sudo_as_admin_successful
if [ "$compare_versions" -eq 1 ]; then # Apply tweak only if sudo version is greater than or equal to 1.9.6
  echo 'Defaults    !admin_flag' | sudo tee -a /etc/sudoers > /dev/null
fi


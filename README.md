# Claude Unlimited

Welcome to the **Claude Unlimited** repository! This project provides the configuration files necessary to use Claude CLI (Claude Code) and Claude Desktop with custom local proxy endpoints and settings (via LiteLLM).

## 🚀 Features
- **Custom Local Proxy**: Configure local proxy servers utilizing `litellm_config.yaml`.
- **Claude CLI Configuration**: Provides optimized settings via `settings.json`.
- **Claude Desktop Integration**: Unlocks developer modes to configure 3rd party inference directly in the Desktop App.

---

## 🛠️ Prerequisites
- [LiteLLM](https://github.com/BerriAI/litellm) installed on your system.
- Claude Desktop App installed.
- Claude CLI (Claude Code) installed.

---

## 📖 How to Run and Execute

### 1. Start LiteLLM
First, you need to install LiteLLM with proxy support and run the proxy server using the provided configuration file.
```bash
pip install 'litellm[proxy]'
litellm --config litellm_config.yaml --port 4000
```
*Ensure that you have updated your API keys inside `litellm_config.yaml` before running the proxy.*

### 2. Configure Claude CLI (Claude Code)
To configure the command-line interface for Claude, follow these simple steps:
1. Press **`Win + R`** to open the Windows Run dialog.
2. Paste the following command and hit **Enter**:
   ```cmd
   %userprofile%\.claude
   ```
3. The `.claude` folder will open in File Explorer. **Copy** the `settings.json` file from this repository and **Paste** it into the `.claude` folder.
4. If prompted to replace an existing file, click **Replace the file in the destination**.

### 3. Configure Claude Desktop
To enable 3rd party inference in the Claude Desktop app:
1. Open the **Claude Desktop App**.
2. Click on the **Menu** in the top corner.
3. Navigate to **Help** ➡️ **Troubleshoot** ➡️ **Enable Developer Mode**.
4. Go back to the **Menu**. You will now see a new **Developer** option available. 
   
   ![Developer Menu](Screenshot%20(25).png)

5. Click on **Developer** and select **Configure 3rd Party Inference**.
6. Fill in the details exactly as shown in the screenshots below to complete the setup:

   **Configuration Step 1:**
   
   ![Config 1](Screenshot%20(22).png)

   **Configuration Step 2:**
   
   ![Config 2](Screenshot%20(23).png)

   **Configuration Step 3:**
   
   ![Config 3](Screenshot%20(24).png)

---

## ✨ Credits
Created and Maintained by **[RKD-Coder](https://github.com/RKD-Coder)**.

# hashicorp/vault

## Vault Initialization and Unseal (UI Guide)

This guide explains how to initialize and unseal HashiCorp Vault deployed on k3s using Helm, **via the UI**, up to the point of logging in.

* *Initialization is always required on first deployment.*
* *Manual unseal is required after every restart unless auto-unseal is configured.*
* *For simple in-cluster secrets usage, many teams just initialize once and keep keys safe.*


---

### 1. Access the Vault UI

Open your browser and navigate to your Vault UI:

### 2. Initialize Vault

1. On the main screen, you will see: `Let's set up the initial set of root keys that you will need in case of an emergency.`
2. Enter the following values:

- **Key Shares:** `5`  
- **Key Threshold:** `3`

3. Click **Initialize**.

4. Vault will generate:

- **5 unseal keys** (any 3 are needed to unseal Vault)  
- **Initial root token**

5. **Important:** Store the **unseal keys** and **root token** securely offline or in a safe password manager.

---

### 3. Unseal Vault

Vault is initially **sealed**. To unseal:

1. Enter **Unseal Key Portion 1** in the UI form and click **Unseal**.  
2. Enter **Unseal Key Portion 2** and click **Unseal**.  
3. Enter **Unseal Key Portion 3** and click **Unseal**.  

Once 3 keys are entered, Vault will become **unsealed**.

---

### 4. Login to Vault

1. In the UI, click **Login**.  
2. Select **Token** as the authentication method.  
3. Enter the **Initial Root Token** generated during initialization.  

Vault is now **unsealed and ready for use**.


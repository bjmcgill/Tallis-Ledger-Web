# Tallis Ledger Web

## 06/04/2026

This is a port of my python tkinter Tallis-Ledger accounting app. It uses JavaScript React Express Vite and MySQL.

A detailed description of the code can be found in CLAUDE.md

This app was vibe coded using Claude Code. The main prompts can be found at INSTRUCTIONS.md and INSTRUCTIONS2.md.

Currently the app works perfectly in dev mode, but when I try to publish the production version on a Krystal web server, using cPanel, I get the error message unexpected token '<' when clicking on the submit button on the first page. The network response on clicking the button is a html file which says 'Cannot POST /accounts/api/auth/connect.' it should be a Javascript file.

The URL for the app is designed to be something like mydomain.com/accounts. In dev mode, the URL is localhost:5173. There is no accounts subdirectory. This is accounted for in the code.

I uploaded the server files to Tallis-Ledger-Web/server and the dist files to public_html/accounts

Also I uploaded the dist files to Tallis-Ledger-Web/client/dist. I could probably have used a symbolic link here.

The Tallis-Ledger-Web/client/src/services source folder contains the files

accountService.js
authService.js
fundService.js
ledgerService.js
transactionsService.js

all of these files import apiBase.js which contains the code:

```
const apiBase = import.meta.env.MODE === 'production' ? '/accounts' : '';
export default apiBase;
```

this should add the /accounts prefix in production mode.

The vite.config.js file contains:

```
export default defineConfig(({ mode }) => ({
  base: mode === 'production' ? '/accounts/' : '/',
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:3001',
        changeOrigin: true,
        secure: false,
      },
    },
  },
}));
```

This should also add the /accounts/ base in production mode.

If you have any ideas on fixing this problem please let me know by emailing bjmcgill34@gmail.com . It would be much appreciated.

You can see my full stack overflow question with added details including my .htaccess files at https://stackoverflow.com/questions/79920822/trying-to-install-node-js-app-on-cloudlinux-server-using-cpanel-and-passenger
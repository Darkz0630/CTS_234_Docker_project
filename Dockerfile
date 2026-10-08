FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Download and install Node.js manually
RUN powershell -Command \
    Invoke-WebRequest -Uri https://nodejs.org/dist/v20.18.0/node-v20.18.0-win-x64.zip -OutFile C:\node.zip; \
    Expand-Archive -Path C:\node.zip -DestinationPath C:\ ; \
    Rename-Item -Path 'C:\node-v20.18.0-win-x64' -NewName 'C:\nodejs'; \
    Remove-Item C:\node.zip

# Add Node to PATH so 'node' and 'npm' commands work
RUN setx /M PATH "%PATH%;C:\nodejs"

WORKDIR C:\\app

COPY package.json .
RUN C:\nodejs\npm.cmd install

COPY server.js .
COPY public ./public

EXPOSE 80

CMD ["C:\\nodejs\\node.exe", "server.js"]
#!/bin/bash

set -e

echo "🚀 FotoAI Platform Setup Script"
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

command -v docker >/dev/null 2>&1 || { echo -e "${RED}Docker is required but not installed. Aborting.${NC}" >&2; exit 1; }
command -v node >/dev/null 2>&1 || { echo -e "${RED}Node.js is required but not installed. Aborting.${NC}" >&2; exit 1; }
command -v dotnet >/dev/null 2>&1 || { echo -e "${RED}.NET SDK is required but not installed. Aborting.${NC}" >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo -e "${RED}Python 3 is required but not installed. Aborting.${NC}" >&2; exit 1; }

echo -e "${GREEN}✓ All prerequisites found${NC}"

# Create environment files
echo -e "\n${YELLOW}Setting up environment files...${NC}"

if [ ! -f .env ]; then
    cp .env.example .env
    # Generate JWT secret
    JWT_SECRET=$(openssl rand -base64 32)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s|JWT_SECRET=.*|JWT_SECRET=$JWT_SECRET|" .env
    else
        sed -i "s|JWT_SECRET=.*|JWT_SECRET=$JWT_SECRET|" .env
    fi
    echo -e "${GREEN}✓ Created .env file${NC}"
else
    echo -e "${YELLOW}⚠ .env file already exists, skipping${NC}"
fi

if [ ! -f frontend/.env.local ]; then
    cp frontend/.env.example frontend/.env.local
    echo -e "${GREEN}✓ Created frontend/.env.local${NC}"
else
    echo -e "${YELLOW}⚠ frontend/.env.local already exists, skipping${NC}"
fi

if [ ! -f backend/appsettings.json ]; then
    cp backend/appsettings.example.json backend/appsettings.json
    echo -e "${GREEN}✓ Created backend/appsettings.json${NC}"
else
    echo -e "${YELLOW}⚠ backend/appsettings.json already exists, skipping${NC}"
fi

# Install frontend dependencies
echo -e "\n${YELLOW}Installing frontend dependencies...${NC}"
cd frontend
if command -v pnpm >/dev/null 2>&1; then
    pnpm install
else
    npm install
fi
cd ..
echo -e "${GREEN}✓ Frontend dependencies installed${NC}"

# Install backend dependencies
echo -e "\n${YELLOW}Installing backend dependencies...${NC}"
cd backend
dotnet restore
cd ..
echo -e "${GREEN}✓ Backend dependencies installed${NC}"

# Install AI services dependencies
echo -e "\n${YELLOW}Installing AI services dependencies...${NC}"
cd ai-services
pip3 install -r requirements.txt
cd ..
echo -e "${GREEN}✓ AI services dependencies installed${NC}"

# Create necessary directories
echo -e "\n${YELLOW}Creating directories...${NC}"
mkdir -p backend/uploads
mkdir -p backend/processed
mkdir -p ai-services/models
echo -e "${GREEN}✓ Directories created${NC}"

# Start Docker services
echo -e "\n${YELLOW}Starting Docker services...${NC}"
docker-compose up -d postgres redis
echo -e "${GREEN}✓ Database and Redis started${NC}"

# Wait for database to be ready
echo -e "\n${YELLOW}Waiting for database to be ready...${NC}"
sleep 5

# Run database migrations
echo -e "\n${YELLOW}Running database migrations...${NC}"
cd backend
dotnet ef database update
cd ..
echo -e "${GREEN}✓ Database migrations complete${NC}"

echo -e "\n${GREEN}================================${NC}"
echo -e "${GREEN}✓ Setup complete!${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo -e "1. Review and update .env file with your settings"
echo -e "2. Start all services: ${GREEN}docker-compose up -d${NC}"
echo -e "3. Access the platform:"
echo -e "   - Frontend: ${GREEN}http://localhost:3000${NC}"
echo -e "   - Backend API: ${GREEN}http://localhost:5000${NC}"
echo -e "   - API Docs: ${GREEN}http://localhost:5000/swagger${NC}"
echo -e "\n${YELLOW}For detailed instructions, see SETUP.md${NC}"

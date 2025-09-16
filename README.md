# Coda

A Spotify Dashboard that visualizes your listening habits and top tracks/artists.

## Prerequisites

- Docker and Docker Compose
- Spotify Account + Spotify API credentials

### Obtaining Spotify API keys

1. Log in to [Spotify for Developers](https://developer.spotify.com/) using your Spotify account
2. Go to dashboard and create an app
3. Copy the **Client ID** and **Client secret**
4. In the app settings, scroll to **Redirect URIs** and add **http://127.0.0.1:3000/auth/spotify/callback**
5. Create `.env` file in project root and add these to the file:

```bash
SPOTIFY_CLIENT_ID=your_spotify_client_id
SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
SPOTIFY_REDIRECT_URI=your_redirect_uri
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
```

## Running locally (Docker)

This project requires valid API

1. Clone repo

```
git clone https://github.com/your-username/coda.git
cd coda
```

2. Create `.env` file in project root. See [Obtaining Spotify API keys](#obtaining-spotify-api-keys)

```bash
SPOTIFY_CLIENT_ID=your_spotify_client_id
SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
SPOTIFY_REDIRECT_URI=your_redirect_uri
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
```

3. Ensure `entrypoint.sh` has LF line breaks
  - Check bottom right corner of VSCode
  - Change to LF and save

4. Build and start the containers:

```bash
docker compose build
docker compose up
```

5. If running for first time, setup database

```bash
docker compose run web rails db:create db:migrate
```

5. Access the application:

- Open http://127.0.0.1:3000

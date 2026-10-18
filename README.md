# 🗺️ OpenCampus GIS: 3D Campus Map & Barrier-Free Navigation Platform

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![Deploy: Docker Compose](https://img.shields.io/badge/Deploy-Docker%20Compose-2496ED?logo=docker)](./docker-compose.yml)
[![Spatial DB: PostGIS](https://img.shields.io/badge/Spatial%20DB-PostGIS%20%2B%20pgRouting-336791?logo=postgresql)](https://postgis.net/)
[![Routing: Dijkstra / A*](https://img.shields.io/badge/Routing-Dijkstra%20%2F%20A*-brightgreen)](./js/algorithms.js)
[![Status: Active Development](https://img.shields.io/badge/Status-Active%20Academic%20Project-success)](https://github.com)

**OpenCampus GIS** is an open-source, non-profit interactive campus spatial navigation and accessible routing platform developed and maintained by our University Student GIS & Developer Club.

Mainstream commercial navigation platforms frequently lack granular pedestrian pathways, indoor walkways, multi-floor connectors, classroom-level indexing, and dedicated wheelchair-accessible routing across higher education campuses. OpenCampus GIS addresses these limitations by pairing **Leaflet.js / MapLibre** visualization with a high-performance **GeoJSON graph engine**, **PostGIS spatial database**, and **in-memory Dijkstra/A* pathfinding algorithms**.

---

## ✨ Key Features

- **♿ Barrier-Free & Multi-Modal Routing**: Real-time shortest-path calculation (Dijkstra, BFS, DFS) with dedicated filters for accessible ramps, elevators, and pedestrian-only thoroughfares.
- **🏢 Campus Facilities & Classroom Indexing**: Instant fuzzy search across lecture halls, laboratory complexes, student centers, libraries, and campus amenities.
- **🧱 Spatial Vector & 3D Building Rendering**: High-efficiency vector tile serving via TileServer GL, OpenStreetMap data extracts, and custom campus polygon overlays.
- **⚡ In-Memory Graph Caching**: Rapid route queries utilizing Redis and in-memory adjacency structures to smoothly handle student traffic surges during inter-class transitions.
- **📊 Automated GeoJSON Pipeline**: Built-in Python processing pipeline (`processgeoJSON.py`) to parse, clean, and compile raw campus geospatial nodes into topological routing networks.

---

## 🏗️ System Architecture & Production Requirements

To ensure sub-second routing calculations and smooth vector tile rendering during peak campus hours, OpenCampus GIS is designed as a containerized multi-tier stack:

| Container Service | Stack & Technology | Resource & Functional Role |
| :--- | :--- | :--- |
| **`opencampus-db`** | PostgreSQL 15 + **PostGIS 3.3** | Geospatial polygon storage, spatial R-Tree indexing, building footprint geometries. |
| **`opencampus-cache`** | **Redis 7-Alpine** | High-speed cache for precomputed shortest-path corridors and frequently queried map tiles. |
| **`opencampus-tiles`** | **TileServer GL** | Vector tile generation from `.osm.pbf` and custom campus MBTiles packages. |
| **`opencampus-web`** | **Nginx + Leaflet.js / ES6** | Client-facing portal, interactive canvas rendering, and user pathfinding UI. |

### Recommended Production Specifications
- **CPU**: 4 – 8 vCPUs *(Required for spatial polygon processing, concurrent Dijkstra graph traversals, and multi-thread tile rendering)*
- **RAM**: 8 – 16 GB RAM *(Required for PostGIS `shared_buffers`, in-memory routing adjacency tables, and Redis tile caching layer)*
- **Storage**: 80 – 120 GB SSD/NVMe *(Allocated for campus orthophoto imagery, vector tile MBTiles packages, spatial database tables, and rotating server logs)*

*(Note: While an 8 vCPU / 16 GB instance allows running the complete OSM tile rendering pipeline locally, a 4 vCPU / 8 GB configuration provides an excellent baseline for core routing and campus visualization services.)*

---

## 🚀 Quick Start & Deployment

### 1. Clone & Setup
```bash
git clone https://github.com/CampusMap-OpenLab/open-campus-map.git
cd opencampus-gis-platform
```

### 2. Preprocess Campus Geospatial Network
```bash
# Install Python dependencies
pip install -r requirements.txt

# Compile raw GeoJSON into node/edge graph representations
python processgeoJSON.py
```

### 3. Launch with Docker Compose
```bash
docker compose up -d
```
Access the interactive campus map portal at `http://localhost:80` (or `http://your-server-ip`).

---

## 📂 Project Structure

```text
opencampus-gis-platform/
├── index.html              # Main interactive map interface & navigation controls
├── docker-compose.yml      # Multi-tier containerized stack (PostGIS + Redis + Web)
├── Dockerfile              # Production container build specification
├── requirements.txt        # Python geospatial processing dependencies
├── processgeoJSON.py       # Python pipeline compiling raw GeoJSON into routing graph
├── campus_nodes_edges.json # Processed topological graph (nodes, edges, distances)
├── css/
│   └── styles.css          # Map overlay styling & responsive layout
├── js/
│   ├── algorithms.js       # Core pathfinding engine (Dijkstra, BFS, DFS)
│   ├── graph.js            # In-memory graph data structure & adjacency lists
│   └── app.js              # Leaflet setup, layer controls, and routing controller
├── data/
│   └── data.geojson        # High-resolution campus feature and building geometries
├── LICENSE                 # Open-source MIT license
└── README.md               # Academic project overview & technical documentation
```

---

## 🤝 Academic & Infrastructure Partner

This initiative is a **100% non-commercial open-source educational project** developed for university students, faculty members, and campus visitors.

Cloud and geospatial routing infrastructure is proudly supported by [**BlueServers**](https://blueservers.com).

[![Infrastructure Supported by BlueServers](https://img.shields.io/badge/Infrastructure-BlueServers-0284c7?style=for-the-badge&logo=server&logoColor=white)](https://blueservers.com)

---

## 📜 License

Distributed under the [MIT License](./LICENSE). Free for academic, educational, and public-good research use.

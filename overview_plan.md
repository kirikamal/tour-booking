# Tour Booking & Vehicle Hire Website — Overview Plan

> Modelled after [prasannatoursandtransport.com.au](https://prasannatoursandtransport.com.au/)
> Date: 2026-03-02

---

## 1. Site Analysis Summary

The reference site is a small Australian tour/transport business (Pendle Hill, NSW) with:

| Feature | Detail |
|---|---|
| Business type | Day-trip tours + airport transfers + vehicle hire |
| Booking flows | 3: Tour, Airport Transfer, Vehicle Hire |
| Tour packages | 6 fixed day-trips with per-person pricing |
| Pages | Home, About, Tours, Booking (×3), Gallery, Reviews, Contact |
| Contact channels | Phone, Email, WhatsApp, Facebook (fixed right sidebar) |
| Current tech | PHP flat-file pages |
| Design style | Hero banner, package grid cards, stats bar, testimonials |

### Tour Packages (reference)
| Destination | Price/Person |
|---|---|
| Canberra | $115 |
| Blue Mountains | $75 |
| Jervis Bay | $110 |
| Kiama | $95 |
| Nelson Bay | $110 |
| Snowy Mountains | $250 |

---

## 2. Technology Recommendation

### Verdict: **Ruby on Rails** (full-stack, recommended)

#### Comparison

| Criteria | Ruby on Rails | Node.js (Next.js) | CMS (WordPress) |
|---|---|---|---|
| Development speed | Fast — convention over config | Medium — more boilerplate | Fast for simple, slow to customise |
| Booking form handling | Excellent (built-in form helpers, validations) | Good (manual setup) | Plugin-dependent, brittle |
| Admin panel | `ActiveAdmin` or `Administrate` — near zero config | Requires custom build or 3rd-party | Built-in but inflexible |
| Email notifications | `Action Mailer` — built-in, battle-tested | Nodemailer (manual config) | SMTP plugins |
| Database ORM | `Active Record` — migrations, validations, associations | Prisma / Sequelize | Built-in (limited schema control) |
| SEO | Good (server-side rendering) | Excellent (Next.js SSG/SSR) | Good |
| Customisability | High | Very high | Low |
| Hosting cost | Low (Render, Fly.io free tiers) | Low (Vercel, Railway) | Medium (managed WP hosting) |
| Maintenance | Low — monolith, one codebase | Medium — separate concerns | High — plugin conflicts, updates |
| Best for | This project | Complex SPA / real-time apps | Blogs, simple brochure sites |

#### Why Rails wins here
- **3 booking forms** with validations, date pickers, passenger counts → Rails form objects + Active Record validations handle this cleanly
- **Admin panel** to manage bookings, tours, vehicles, reviews → `ActiveAdmin` delivers a full CRUD dashboard in ~30 minutes
- **Email notifications** → `Action Mailer` + `letter_opener` gem for dev previews; production via SendGrid/Postmark
- **Content updates** (tour prices, packages) → ActiveAdmin gives the business owner a web UI without touching code
- **SEO** → server-rendered HTML out of the box, no hydration complexity
- **Monolith simplicity** → one `git push` to deploy, no separate frontend/backend services
- **Tailwind CSS** integrates cleanly via `tailwindcss-rails` gem

> **Alternative**: If the team has strong JavaScript preference, **Next.js + Prisma + PostgreSQL** is a solid second choice — SSG for tour pages (great SEO), API routes for booking submissions, and a headless CMS (Sanity or Contentlayer) for content. The tradeoff is more moving parts and no built-in admin panel.

---

## 3. Recommended Tech Stack

### Core
| Layer | Technology |
|---|---|
| Language | Ruby 3.3+ |
| Framework | Ruby on Rails 8.x |
| Database | PostgreSQL |
| CSS | Tailwind CSS (`tailwindcss-rails`) |
| JavaScript | Hotwire (Turbo + Stimulus) — minimal JS, no heavy SPA |
| Asset pipeline | Propshaft |

### Key Gems
| Gem | Purpose |
|---|---|
| `activeadmin` | Admin panel (bookings, tours, vehicles, reviews) |
| `devise` | Admin authentication |
| `action_mailer` | Booking confirmation emails (built-in) |
| `letter_opener` | Email preview in development |
| `image_processing` + `active_storage` | Gallery image uploads |
| `pagy` | Pagination (bookings list in admin) |
| `ransack` | Search/filter in admin |
| `noticed` | Notification system (optional) |
| `pg` | PostgreSQL adapter |
| `dotenv-rails` | Environment variable management |
| `meta-tags` | SEO meta tag helpers |

### External Services
| Service | Purpose |
|---|---|
| SendGrid / Postmark | Transactional email (production) |
| Cloudinary (optional) | Image hosting/optimisation for gallery |
| Google Maps Embed | Tour destination maps (optional) |
| Stripe (future phase) | Online payments |

---

## 4. Database Schema

### `tours`
```
id            integer PK
name          string        -- "Blue Mountains Day Trip"
slug          string        -- "blue-mountains"
description   text
price_cents   integer       -- store in cents to avoid float issues
duration      string        -- "1 Day"
departure_time string       -- "7:00 AM"
pickup_location string      -- "Parramatta Station"
max_passengers integer
highlights    text[]        -- array of bullet points
featured_image_url string
active        boolean       default true
position      integer       -- for ordering
created_at / updated_at
```

### `tour_bookings`
```
id              integer PK
tour_id         integer FK → tours
booking_ref     string        -- auto-generated e.g. "TBK-20260302-001"
full_name       string
email           string
phone           string
travel_date     date
num_passengers  integer
pickup_point    string
special_requests text
status          enum          -- pending, confirmed, cancelled
total_amount_cents integer
created_at / updated_at
```

### `airport_bookings`
```
id              integer PK
booking_ref     string
full_name       string
email           string
phone           string
trip_type       enum          -- pickup, dropoff
airport         string        -- "Sydney (SYD)"
flight_number   string
flight_datetime datetime
num_passengers  integer
address         text          -- home/hotel address
vehicle_type    string        -- "Sedan", "SUV", "Van"
notes           text
status          enum          -- pending, confirmed, cancelled
created_at / updated_at
```

### `vehicle_bookings`
```
id              integer PK
booking_ref     string
full_name       string
email           string
phone           string
vehicle_id      integer FK → vehicles
pickup_date     date
return_date     date
pickup_location string
num_passengers  integer
notes           text
status          enum          -- pending, confirmed, cancelled
created_at / updated_at
```

### `vehicles`
```
id              integer PK
name            string        -- "Toyota HiAce 13-Seater"
vehicle_type    string        -- "Van", "SUV", "Sedan", "Bus"
capacity        integer
description     text
features        text[]
image_url       string
available       boolean       default true
position        integer
```

### `gallery_images`
```
id          integer PK
caption     string
category    string    -- "tours", "vehicles", "events"
position    integer
-- image attached via ActiveStorage
```

### `reviews`
```
id          integer PK
author_name string
rating      integer   -- 1-5
body        text
tour_id     integer FK (nullable, for tour-specific reviews)
approved    boolean   default false
created_at
```

### `pages` (for About, static content)
```
id          integer PK
slug        string    -- "about-us"
title       string
body        text      -- HTML/Markdown
meta_title  string
meta_description string
```

---

## 5. Page & Route Structure

```
GET  /                          → Home (hero, tour grid, stats, testimonials, CTA)
GET  /about                     → About Us
GET  /tours                     → All Tours listing
GET  /tours/:slug               → Individual Tour detail + booking CTA

GET  /booking/tour              → Tour booking form
POST /booking/tour              → Submit tour booking → confirmation + email

GET  /booking/airport           → Airport transfer form
POST /booking/airport           → Submit → confirmation + email

GET  /booking/vehicle           → Vehicle hire form
POST /booking/vehicle           → Submit → confirmation + email

GET  /booking/confirmation/:ref → Booking confirmation page

GET  /gallery                   → Photo gallery grid
GET  /reviews                   → Customer reviews
GET  /contact                   → Contact form + map + details

# Admin (ActiveAdmin — protected by Devise)
GET  /admin                     → Dashboard (booking stats)
     /admin/tour_bookings        → CRUD, status updates, export CSV
     /admin/airport_bookings     → CRUD, status updates
     /admin/vehicle_bookings     → CRUD, status updates
     /admin/tours                → Tour CRUD (name, price, image, description)
     /admin/vehicles             → Vehicle CRUD
     /admin/reviews              → Approve/reject reviews
     /admin/gallery_images       → Upload/reorder gallery photos
     /admin/pages                → Edit static page content
```

---

## 6. Key Features & Components

### Public Site

#### Home Page
- Full-width hero banner (Swiper.js slider or static image + Tailwind overlay)
- Stats bar: years experience, happy travellers, guides count
- Tour packages grid (card per tour: image, name, price, "Book Now" CTA)
- Why Choose Us section (icons + bullet points)
- Testimonials carousel (from `reviews` table, approved only)
- Fixed right sidebar: Phone, Email, WhatsApp, Facebook icons
- Sticky header with nav + mobile hamburger menu

#### Booking Forms (shared UX pattern)
- Multi-step feel using Stimulus controller (step 1: trip details, step 2: personal info)
- Date picker: Flatpickr (lightweight, no jQuery dependency)
- Live passenger count with total price calculation (Stimulus)
- Client-side validation + server-side Rails validations
- CSRF protection (Rails default)
- On success: redirect to `/booking/confirmation/:ref`
- Emails dispatched via `ActiveMailer` + background job (`Solid Queue` — Rails 8 default)

#### Tour Detail Page
- Hero image, highlights list, departure info, itinerary
- "Book This Tour" button → pre-fills tour on booking form
- Related tours section

#### Gallery
- Masonry or uniform grid layout
- Lightbox on click (GLightbox — vanilla JS, lightweight)
- Filter by category (Stimulus controller, no page reload)

#### Reviews Page
- Star rating display, reviewer name, review body
- Optionally a "Leave a Review" form (held for admin approval)

### Admin Panel (ActiveAdmin)
- Dashboard: today's bookings count, pending confirmations, revenue summary
- Booking management: view, status change (pending → confirmed → cancelled), notes
- One-click email to customer from admin
- Tour/vehicle CRUD with image upload
- Review moderation queue
- CSV export for bookings

### Email Notifications
- **Customer**: Booking reference, trip details, contact info, "what to bring"
- **Admin**: New booking alert with all details + link to admin panel
- Designed HTML templates using Rails mailer views + inline CSS

---

## 7. Project Structure

```
taxi-app/
├── app/
│   ├── controllers/
│   │   ├── bookings/
│   │   │   ├── tours_controller.rb
│   │   │   ├── airports_controller.rb
│   │   │   └── vehicles_controller.rb
│   │   ├── tours_controller.rb
│   │   ├── gallery_controller.rb
│   │   └── reviews_controller.rb
│   ├── models/
│   │   ├── tour.rb
│   │   ├── tour_booking.rb
│   │   ├── airport_booking.rb
│   │   ├── vehicle_booking.rb
│   │   ├── vehicle.rb
│   │   ├── review.rb
│   │   └── gallery_image.rb
│   ├── mailers/
│   │   ├── tour_booking_mailer.rb
│   │   ├── airport_booking_mailer.rb
│   │   └── vehicle_booking_mailer.rb
│   ├── views/
│   │   ├── layouts/application.html.erb
│   │   ├── home/index.html.erb
│   │   ├── tours/
│   │   ├── bookings/
│   │   ├── gallery/
│   │   └── mailers/
│   ├── javascript/
│   │   └── controllers/  (Stimulus controllers)
│   └── admin/            (ActiveAdmin resources)
├── config/
│   ├── routes.rb
│   └── environments/
├── db/
│   ├── schema.rb
│   └── migrate/
└── Gemfile
```

---

## 8. Phased Build Plan

### Phase 1 — Foundation (Week 1)
- [ ] `rails new taxi-app --database=postgresql --asset-pipeline=propshaft`
- [ ] Install Tailwind CSS, Hotwire
- [ ] Set up PostgreSQL database
- [ ] Create models + migrations (tours, vehicles, reviews)
- [ ] Seed data (6 tour packages, sample vehicles)
- [ ] Build layout: header, footer, fixed social sidebar

### Phase 2 — Public Pages (Week 2)
- [ ] Home page (hero, tour grid, stats, testimonials)
- [ ] Tours listing + individual tour pages
- [ ] About Us, Gallery, Reviews, Contact pages
- [ ] Mobile responsive (Tailwind breakpoints)

### Phase 3 — Booking System (Week 3)
- [ ] Tour booking form + model + validations
- [ ] Airport booking form + model
- [ ] Vehicle hire form + model
- [ ] Booking reference auto-generation
- [ ] Confirmation page
- [ ] Email notifications (customer + admin)

### Phase 4 — Admin Panel (Week 4)
- [ ] Install ActiveAdmin + Devise
- [ ] Booking management (view, status, notes)
- [ ] Tour/Vehicle CRUD with image upload
- [ ] Review moderation
- [ ] Gallery image management
- [ ] Dashboard stats

### Phase 5 — Polish & Deploy (Week 5)
- [ ] SEO: meta tags, sitemap, robots.txt, structured data (LocalBusiness schema)
- [ ] Performance: image optimisation, caching
- [ ] Google Analytics setup
- [ ] Final QA + cross-browser/device testing
- [ ] Deploy to production

---

## 9. Deployment Recommendation

### Recommended: **Render.com**

| Option | Cost | Ease | Notes |
|---|---|---|---|
| **Render.com** | Free tier → ~$7/mo | Very easy | Auto-deploys from GitHub, managed PostgreSQL, SSL included |
| Fly.io | Free tier → ~$5/mo | Medium | More control, great for Rails |
| Heroku | ~$12/mo | Easy | More expensive now, was the Rails standard |
| DigitalOcean App Platform | ~$12/mo | Easy | Good reliability |
| VPS (DigitalOcean Droplet) | ~$6/mo | Hard | Full control, manual setup |

### Render Setup
1. Push to GitHub
2. Create Web Service → connect repo → `bundle exec rails server`
3. Create PostgreSQL database → link via `DATABASE_URL`
4. Set env vars: `RAILS_MASTER_KEY`, `SENDGRID_API_KEY`, `ADMIN_EMAIL`
5. Custom domain → add CNAME → free SSL via Let's Encrypt

### Domain & Email
- Register domain via Namecheap / GoDaddy (~$15/yr)
- Transactional email: **SendGrid** (free tier: 100 emails/day) or **Postmark** ($15/mo — more reliable deliverability)

---

## 10. Estimated Effort Summary

| Phase | Effort |
|---|---|
| Phase 1 — Foundation | 3–5 days |
| Phase 2 — Public pages | 4–6 days |
| Phase 3 — Booking system | 4–5 days |
| Phase 4 — Admin panel | 2–3 days |
| Phase 5 — Polish & deploy | 2–3 days |
| **Total** | **~4–5 weeks** (solo developer) |

---

*Plan generated for: `/Users/admin/dev/demo/taxi-app`*

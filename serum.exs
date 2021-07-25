%{
  site_name: "Vetspire",
  site_description: "Pictures of dogs: the best thing on the internet",
  date_format: "{WDfull}, {D} {Mshort} {YYYY}",
  base_url: "/",
  author: "John Doe",
  author_email: "john.doe@example.com",
  plugins: [
    {Serum.Plugins.LiveReloader, only: :dev}
  ],
  theme: Serum.Themes.Essence
}

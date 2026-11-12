module ApplicationHelper
  DEFAULT_FLAT_PICTURE_URL = "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80".freeze

  def flat_picture_url(flat)
    url = flat.picture_url.to_s.strip
    return url if url.match?(%r{\Ahttps?://}i)

    DEFAULT_FLAT_PICTURE_URL
  end
end

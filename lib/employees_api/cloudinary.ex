defmodule EmployeesApi.Cloudinary do
  def upload(params) do
    send_put(params)
    |> Map.fetch!(:body)
    |> Jason.decode!
  end

  defp send_put(params) do
    headers = ["Content-Type": "multipart/form-data"]
    options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 5000]

    HTTPoison.request!(
      :post,
      "https://api.cloudinary.com/v1_1/#{System.fetch_env!("CLOUDINARY_CLOUD_NAME")}/image/upload",
      build_request(params),
      headers,
      options
    )
  end

  defp build_request(%{filename: filename, path: path}) do
    binary_image = File.read!(path)
    defaults = default_params()

    {
      :multipart,
      [
        {
          "file",
          binary_image,
          {
            "form-data",
            [name: "file", filename: filename]
          },
          []
        },
        {"api_key", System.fetch_env!("CLOUDINARY_API_KEY")},
        {"timestamp", defaults.timestamp},
        {"signature", defaults.signature},
      ]
    }
  end

  defp default_params do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()
    secret = System.fetch_env!("CLOUDINARY_SECRET")
    signature = :crypto.hash(:sha, "timestamp=#{timestamp}#{secret}") |> Base.encode16()

    %{
      timestamp: Integer.to_string(timestamp),
      signature: signature
    }
  end
end

defmodule EmployeesApi.Cloudinary do
  @endpoint "https://api.cloudinary.com/v1_1"
  @cloudinary_url URI.parse(System.fetch_env!("CLOUDINARY_URL"))

  def upload(params) do
    params
    |> send_put()
    |> Map.fetch!(:body)
    |> Jason.decode!()
  end

  def destroy(public_id) do
    HTTPoison.post!(
      "#{endpoint()}/image/destroy",
      %{"public_id" => public_id} |> build_body() |> Jason.encode!(),
      "Content-Type": "application/json"
    )
  end

  defp send_put(params) do
    HTTPoison.post!(
      "#{endpoint()}/image/upload",
      build_multipart(params),
      "Content-Type": "multipart/form-data"
    )
  end

  defp endpoint() do
    @endpoint <> "/" <> elem(parse_cloudinary_url(), 2)
  end

  defp build_multipart(%{filename: filename, path: path, content_type: content_type}) do
    {
      :multipart,
      [
        {
          "file",
          File.read!(path),
          {
            "form-data",
            [name: "file", filename: filename]
          },
          ["Content-Type": content_type]
        }
      ] ++ Map.to_list(build_body())
    }
  end

  defp build_body(additional_params \\ %{}) do
    timestamp = DateTime.utc_now() |> DateTime.to_unix()
    secret = elem(parse_cloudinary_url(), 1)

    queryparams =
      additional_params
      |> Map.merge(%{"timestamp" => timestamp})
      |> URI.encode_query()

    signature = :crypto.hash(:sha, "#{queryparams}#{secret}") |> Base.encode16()

    additional_params
    |> Map.merge(%{
      "timestamp" => Integer.to_string(timestamp),
      "signature" => signature,
      "api_key" => elem(parse_cloudinary_url(), 0)
    })
  end

  defp parse_cloudinary_url() do
    %{host: cloud_name, userinfo: userinfo} = @cloudinary_url
    [api_key, api_secret] = String.split(userinfo, ":")

    {api_key, api_secret, cloud_name}
  end
end

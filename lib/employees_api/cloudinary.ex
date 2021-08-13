defmodule EmployeesApi.Cloudinary do
  @endpoint "https://api.cloudinary.com/v1_1"

  def upload(params) do
    params
    |> send_put
    |> Map.fetch!(:body)
    |> Jason.decode!()
  end

  def destroy(public_id) do
    HTTPoison.post!(
      "#{endpoint()}/image/destroy",
      %{"public_id" => public_id} |> build_body |> Jason.encode!(),
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

  defp endpoint do
    @endpoint <> "/" <> System.fetch_env!("CLOUDINARY_CLOUD_NAME")
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
    secret = System.fetch_env!("CLOUDINARY_SECRET")

    queryparams =
      additional_params
      |> Map.merge(%{"timestamp" => timestamp})
      |> URI.encode_query()

    signature = :crypto.hash(:sha, "#{queryparams}#{secret}") |> Base.encode16()

    additional_params
    |> Map.merge(%{
      "timestamp" => Integer.to_string(timestamp),
      "signature" => signature,
      "api_key" => System.fetch_env!("CLOUDINARY_API_KEY")
    })
  end
end

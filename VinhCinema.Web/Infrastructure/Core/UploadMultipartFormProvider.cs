using System.Net.Http;
using System.Net.Http.Headers;

namespace VinhCinema.Web.Infrastructure.Core
{
    public class UploadMultipartFormProvider : MultipartFormDataStreamProvider
    {
        public UploadMultipartFormProvider(string rootPath) : base(rootPath)
        {
        }

        public override string GetLocalFileName(HttpContentHeaders headers)
        {
            var name = !string.IsNullOrWhiteSpace(headers.ContentDisposition.FileName) ? headers.ContentDisposition.FileName : "NoName";
            return name.Trim(new char[] { '"' })
                        .Replace("&", "and");
        }
    }
}
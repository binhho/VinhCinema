using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using VinhCinema.Web.Infrastructure.Core;

namespace VinhCinema.Web.Controllers
{
    [RoutePrefix("api/upload")]
    public class UploadController : ApiController
    {
        
        [Route("AddUpload")]
        [HttpPost]
        public async Task<IHttpActionResult> Upload(HttpRequestMessage request)
        {
            //_requiredRepositories = new List<Type>() { typeof(Movie) };

            #region Thread
            var photos = new List<FileUploadResult>();

            HttpResponseMessage response = null;
            IHttpActionResult responseMG = null;

            var uploadPath = HttpContext.Current.Server.MapPath("~/Content/images/movies");

            var multipartFormDataStreamProvider = new UploadMultipartFormProvider(uploadPath);

            await request.Content.ReadAsMultipartAsync(multipartFormDataStreamProvider);

            //string _localFileName = multipartFormDataStreamProvider.FileData.Select(multiData => multiData.LocalFileName).FirstOrDefault();

            foreach (var file in multipartFormDataStreamProvider.FileData)
            {
                var fileInfo = new FileInfo(file.LocalFileName);
                photos.Add(new FileUploadResult
                {
                    LocalFilePath = file.LocalFileName,
                    FileName = fileInfo.Name,
                    FileLength = fileInfo.Length / 1024
                });
            }

            response = request.CreateResponse(HttpStatusCode.OK, photos);
            responseMG = ResponseMessage(response);
            return responseMG;

            #endregion Thread

            //return CreateHttpResponse(request, _requiredRepositories, async () =>
            //{
            //    HttpResponseMessage response = null;

            //    var uploadPath = HttpContext.Current.Server.MapPath("~/Content/images/movies");

            //    var multipartFormDataStreamProvider = new UploadMultipartFormProvider(uploadPath);

            //    await request.Content.ReadAsMultipartAsync(multipartFormDataStreamProvider);

            //    string _localFileName = multipartFormDataStreamProvider.FileData.Select(multiData => multiData.LocalFileName).FirstOrDefault();

            //    FileUploadResult fileUploadResult = new FileUploadResult()
            //    {
            //        LocalFilePath = _localFileName,
            //        FileName = Path.GetFileName(_localFileName),
            //        FileLength = new FileInfo(_localFileName).Length
            //    };

            //    response = request.CreateResponse(HttpStatusCode.OK, fileUploadResult);

            //    return response;
            //});
        }
    }
}
